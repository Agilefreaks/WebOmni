require 'spec_helper'

describe Users::OmniauthCallbacksController do
  let(:sample_token) { Hashie::Mash.new(token: 'someToken', refreshToken: 'someOtherToken', expires_in: '1234') }
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]

    allow(OmniApi::Resources::Oauth2::Token).to receive(:create_for).and_return(sample_token)
  end

  describe 'google_oauth2' do
    let(:auth) { Hashie::Mash.new }
    let(:auth_info) { Hashie::Mash.new }
    let(:credentials) do
      Hashie::Mash.new(expires: true,
                       expires_at: Time.zone.now + 1.month,
                       token: 'token',
                       refresh_token: 'refresh_token')
    end

    before do
      auth_info.email = 'email@domain.com'
      auth.info = auth_info
      @request.env['omniauth.auth'] = auth
      auth.credentials = credentials
      @request.env['omniauth.strategy'] = Hashie::Mash.new
      @request.env['omniauth.strategy'].options = { scope: 'authorization_scope' }
    end

    subject { post :google_oauth2 }

    it 'ensures an equivalent api user exists' do
      expect(OmniApi::Factories::UserFactory).to receive(:ensure_user_exists).with(auth)

      subject
    end


    describe 'an equivalent user exists' do
      let!(:user) { Fabricate(:user, email: auth_info.email) }

      describe 'can ensure api user exists' do
        before { allow(OmniApi::Factories::UserFactory).to receive(:ensure_user_exists).with(auth) }

        it 'sets correct values on identity' do
          subject

          identity = User.where(email: 'email@domain.com').first.identity
          expect(identity.token).to eq 'token'
          expect(identity.refresh_token).to eq 'refresh_token'
          expect(identity.expires).to be true
          expect(identity.expires_at.to_i).to eq credentials.expires_at.to_i
        end

        describe "the current user's token is expired" do
          before { user.update_attribute(:access_token_expires_at, 1.day.ago) }

          it "updates the user's token" do
            expect(UpdateUserAccessToken).to receive(:perform)

            subject
          end
        end
      end
    end

    describe 'an equivalent user does not exist' do
      describe 'can create an api user' do
        before { allow(OmniApi::Factories::UserFactory).to receive(:ensure_user_exists).with(auth) }

        it 'sets correct values on identity' do
          subject

          identity = User.where(email: 'email@domain.com').first.identity
          expect(identity.token).to eq 'token'
          expect(identity.refresh_token).to eq 'refresh_token'
          expect(identity.expires).to be true
          expect(identity.expires_at.to_i).to eq credentials.expires_at.to_i
        end

        it "updates the user's token" do
          expect(UpdateUserAccessToken).to receive(:perform)

          subject
        end
      end
    end
  end

  describe 'setup' do
    subject { get :google_oauth2_setup, provider: :google_oauth2 }
    before do
      @request.env['omniauth.strategy'] = Hashie::Mash.new
      @request.env['omniauth.strategy'].options = { scope: '' }
      session[:google_permissions] = ''
    end

    it 'returns 404 in order to go to the normal authentication method' do
      subject
      expect(response).to have_http_status(:not_found)
    end

    context 'there are existing scopes' do
      let(:new_scope) { 'new scope' }

      before do
        session[:google_permissions] = new_scope
      end

      context 'the new scope is not included already' do
        before do
          @request.env['omniauth.strategy'].options[:scope] = 'existing scope'
        end

        it 'merges the existing scopes with the new scopes' do
          subject
          expect(request.env['omniauth.strategy'].options[:scope]).to eq 'existing scope,new scope'
        end
      end

      context 'the new scope is alraedy included' do
        before do
          @request.env['omniauth.strategy'].options[:scope] = 'existing scope,new scope'
        end

        it 'doesnt add the new scope one more time' do
          subject
          expect(request.env['omniauth.strategy'].options[:scope]).to eq 'existing scope,new scope'
        end
      end
    end

    context 'there are no existing scopes' do
      let(:new_scope) { 'new scope' }

      before do
        session[:google_permissions] = new_scope
      end

      it 'sets the new scope' do
        subject
        expect(request.env['omniauth.strategy'].options[:scope]).to eq 'new scope'
      end
    end
  end
end

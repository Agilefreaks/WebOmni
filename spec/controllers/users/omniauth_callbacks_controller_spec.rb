require 'spec_helper'

describe Users::OmniauthCallbacksController do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'google_oauth2' do
    subject { post :google_oauth2 }

    let!(:user) { Fabricate(:user, email: 'email@domain.com')}
    let(:auth) { Hashie::Mash.new }
    let(:auth_info) { Hashie::Mash.new }
    let(:credentials) { Hashie::Mash.new({
                                           expires: true,
                                           expires_at: DateTime.now + 1.month,
                                           token: 'token',
                                           refresh_token: 'refresh_token'
                                         })}

    before do
      auth_info.email = 'email@domain.com'
      auth.info = auth_info
      @request.env['omniauth.auth'] = auth
      auth.credentials = credentials
      @request.env['omniauth.strategy'] = Hashie::Mash.new
      @request.env['omniauth.strategy'].options = { scope: 'authorization_scope' }
    end

    it 'saves the identity on the user' do
      expect { subject }.to change { User.where(email: 'email@domain.com').first.identity }
    end

    it 'sets correct values on identity' do
      subject

      identity = User.where(email: 'email@domain.com').first.identity
      expect(identity.token).to eq 'token'
      expect(identity.refresh_token).to eq 'refresh_token'
      expect(identity.expires).to be true
      expect(identity.expires_at.to_i).to eq credentials.expires_at.to_i
    end
  end

  describe 'setup' do
    subject { get  :google_oauth2_setup, provider: :google_oauth2 }
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
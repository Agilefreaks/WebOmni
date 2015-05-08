require 'spec_helper'

describe Users::OmniauthCallbacksController do
  describe 'setup' do
    subject { get  :google_oauth2_setup, provider: :google_oauth2 }
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
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

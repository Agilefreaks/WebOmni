require 'spec_helper'

describe EmbedablePagesController do
  describe 'user_access_token' do
    subject { get :user_access_token, api_client_id: 1 }

    context 'when user authenticated' do
      include_context :logged_in_as_user

      context 'when given api client does not exist' do
        before { allow(OmniApi::User::Client).to receive(:find).and_raise(ActiveResource::ResourceNotFound.new('test')) }

        it { is_expected.to redirect_to(new_users_client_path(api_client_id: '1')) }
      end

      context 'when given api client exists' do
        before { allow(OmniApi::User::Client).to receive(:find).with('1').and_return(OmniApi::ClientDescription.new) }

        it 'will render user_access_token' do
          subject
          expect(response).to render_template(:user_access_token)
        end
      end
    end

    context 'when user not authenticated' do
      it 'will redirect the user to the login page' do
        subject
        expect(response).to redirect_to(new_user_session_path(locale: ''))
      end
    end
  end
end

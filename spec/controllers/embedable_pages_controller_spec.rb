require 'spec_helper'

describe EmbedablePagesController do
  describe 'user_access_token' do
    subject { get :user_access_token, api_client_id: 1 }

    context 'when given api client does not exist' do
      before { allow(OmniApi::Client).to receive(:where).and_return([]) }

      it 'responds with status 401' do
        subject

        expect(response.status).to eq(401)
      end
    end

    context 'when given api client exists' do
      before { allow(OmniApi::Client).to receive(:where).with(id: '1').and_return([OmniApi::Client.new]) }

      context 'when user authenticated' do
        include_context :logged_in_as_user

        it 'will render user_access_token' do
          subject
          expect(response).to render_template(:user_access_token)
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
end

require 'spec_helper'

describe JsApi::EmbedablePagesController do
  describe 'user_access_token' do
    subject { get :prepare_for_phone_usage, api_client_id: 1 }

    context 'when user authenticated' do
      include_context :logged_in_as_user

      it 'searches for an api client with the given' do
        expect(OmniApi::Resources::Client).to receive(:find).and_raise(ActiveResource::ResourceNotFound.new('test'))

        subject rescue ActiveResource::ResourceNotFound
      end

      context 'when a client with the given id exists' do
        let(:api_client) { OmniApi::Resources::Client.new }

        before { allow(OmniApi::Resources::Client).to receive(:find).and_return(api_client) }

        context 'when a client association does not exist' do
          before { allow(OmniApi::Resources::User::ClientAssociation).to receive(:find).and_raise(ActiveResource::ResourceNotFound.new('test')) }

          it { is_expected.to redirect_to(new_user_client_path(api_client_id: '1')) }

          it 'sets the current path as the callback_url' do
            subject

            expect(session[:callback_url]).to eq(prepare_for_phone_usage_path(1))
          end
        end

        context 'when a client association exists' do
          before { allow(OmniApi::Resources::User::ClientAssociation).to receive(:find).with('1').and_return(OmniApi::Resources::Client.new) }

          context 'when current user has at least one device' do
            before { allow(OmniApi::Resources::User::Device).to receive(:all).and_return([OmniApi::Resources::User::Device.new]) }

            it 'will render user_access_token' do
              subject
              expect(response).to render_template(:prepare_for_phone_usage)
            end
          end

          context 'when current user has no devices' do
            before { allow(OmniApi::Resources::User::Device).to receive(:all).and_return([]) }

            it { is_expected.to redirect_to(new_user_device_path) }
          end
        end
      end
    end

    context 'when user not authenticated' do
      it 'will redirect the user to the login page' do
        subject
        expect(response).to redirect_to(new_user_session_path(locale: 'en'))
      end
    end
  end
end

require 'spec_helper'

describe JsApi::User::ClientsController do
  describe 'get #new' do
    subject { get :new, api_client_id: 1 }

    describe 'user is not authenticated' do
      it { is_expected.to redirect_to(new_user_session_path(locale: 'en')) }
    end

    describe 'user is authenticated' do
      include_context :logged_in_as_user

      context 'a client description with the given id exists' do
        before { allow(OmniApi::Resources::Client).to receive(:find).with('1').and_return(OmniApi::Resources::Client.new) }

        it { is_expected.to render_template(:new) }

        it 'sets the given api_client_id as the client_id on the assigned client' do
          subject

          expect(assigns[:client].client_id).to eq('1')
        end
      end
    end
  end

  describe 'post #create' do
    let(:client_params) { { client_id: 1 } }

    subject { post :create, api_client_id: 1, omni_api_user_client_association: client_params }

    describe 'user is not authenticated' do
      it { is_expected.to redirect_to(new_user_session_path(locale: 'en')) }
    end

    describe 'user is authenticated' do
      include_context :logged_in_as_user

      it 'creates a new user client' do
        expect_any_instance_of(OmniApi::Resources::User::ClientAssociation).to receive(:save)

        subject
      end

      context 'saving the new client is successful' do
        before { allow_any_instance_of(OmniApi::Resources::User::ClientAssociation).to receive(:save).and_return(true) }

        context 'the session contains a callback_url' do
          before { session[:callback_url] = 'http://some.url' }

          it { is_expected.to redirect_to('http://some.url') }
        end
      end

      context 'saving the new client is not successful' do
        let(:exception) { ActiveResource::ResourceNotFound.new(nil, nil) }
        before { allow_any_instance_of(OmniApi::Resources::User::ClientAssociation).to receive(:save).and_raise(exception) }

        it { is_expected.to redirect_to(new_user_client_path(api_client_id: 1)) }

        it 'sets the raised exception in the error flash' do
          subject

          expect(flash[:error]).to eq(exception)
        end
      end
    end
  end
end

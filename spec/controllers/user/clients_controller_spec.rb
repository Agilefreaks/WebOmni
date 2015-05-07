require 'spec_helper'

describe Users::ClientsController do
  describe 'get #new' do
    subject { get :new, api_client_id: 1 }

    describe 'user is not authenticated' do
      it { is_expected.to redirect_to(new_user_session_path(locale: '')) }
    end

    describe 'user is authenticated' do
      include_context :logged_in_as_user

      context 'a client description with the given id exists' do
        before { allow(OmniApi::ClientDescription).to receive(:find).with('1').and_return(OmniApi::ClientDescription.new) }

        it { is_expected.to render_template(:new) }

        it 'sets the given api_client_id as the client_id on the assigned client' do
          subject

          expect(assigns[:client].client_id).to eq('1')
        end
      end
    end
  end

  describe 'post #create' do
    let(:client_params) { {} }

    subject { post :create, client: client_params }

    describe 'user is not authenticated' do
      it { is_expected.to redirect_to(new_user_session_path(locale: '')) }
    end

    describe 'user is authenticated' do
      include_context :logged_in_as_user

      it 'creates a new user client' do
        expect_any_instance_of(OmniApi::User::Client).to receive(:save)

        subject
      end

      context 'saving the new client is successful' do
        before { allow_any_instance_of(OmniApi::User::Client).to receive(:save).and_return(true) }

        context 'the session contains a callback_url' do
          before { session[:callback_url] = 'http://some.url' }

          it { is_expected.to redirect_to('http://some.url') }
        end
      end

      context 'saving the new client is not successful' do
        before { allow_any_instance_of(OmniApi::User::Client).to receive(:save).and_return(false) }

        it { is_expected.to redirect_to(association_failed_path) }
      end
    end
  end
end
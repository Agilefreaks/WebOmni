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
      end
    end
  end
end
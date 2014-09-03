require 'spec_helper'

describe DownloadsController do
  describe "GET 'android_client'" do
    subject { get :android_client, email: email }

    context 'when user is logged in' do
      include_context :logged_in_as_user

      let(:email) { '' }

      it 'will generate code for logged user' do
        CreateAuthorizationCode.should_receive(:for).with(current_user)
        subject
      end
    end

    context 'when email is passed' do
      let(:email) { 'top@oftheworld.com' }
      let!(:user) { Fabricate(:user, email: email) }

      it 'will generate code for user with email' do
        CreateAuthorizationCode.should_receive(:for).with(user)
        subject
      end
    end

  end

  describe "GET 'windows_client'" do
    subject { get :windows_client }

    context 'when there is no user logged in' do
      it 'will redirect to the root page' do
        subject
        expect(response).to redirect_to(root_url(download: true))
      end
    end
  end
end
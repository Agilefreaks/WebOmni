require 'spec_helper'

describe PagesHelper do
  describe 'download_path' do
    subject { helper.download_path }

    context 'when user not signed in' do
      before do
        expect(helper).to receive(:user_signed_in?).twice.and_return(false)
        expect(helper).to receive(:is_mobile_device?).and_return(true)
      end

      it { is_expected.to eq user_omniauth_authorize_path(:google_oauth2, origin: android_client_downloads_path) }
    end
  end
end

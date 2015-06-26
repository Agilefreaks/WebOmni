require 'spec_helper'

describe ApplicationController, type: :controller do
  controller do
    def index
      authenticate!
      render nothing: true
    end
  end

  describe '#authenticate!' do
    subject { get :index }

    context 'a user is logged in' do
      let(:current_user) { Fabricate(:user) }

      before { sign_in(current_user) }

      it 'sets the current user token as the user_access_token in the OmniApi config' do
        subject

        expect(OmniApi.config.user_access_token).to eq("bearer #{current_user.access_token}")
      end
    end
  end
end

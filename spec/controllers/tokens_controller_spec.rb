require 'spec_helper'

describe TokensController do
  let(:user) { mock_model(User, token: '42') }

  describe "GET 'show'" do
    before do
      controller.stub(authenticate_user!: true)
      controller.stub(current_user: user)
      get :show
    end

    it { assigns(:token).should == '42' }
  end
end

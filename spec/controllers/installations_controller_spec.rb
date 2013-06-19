require 'spec_helper'

describe InstallationsController do
  let(:user) { mock_model(User, token: '42') }

  before do
    controller.stub(check_authentication: true)
    controller.stub(current_user: user)
  end

  shared_examples_for 'a installer action' do
    it { should respond_with 200 }

    it { assigns(:token).should == '42' }
  end

  describe "GET 'chrome'" do
    before { get :chrome }

    it_behaves_like 'a installer action'
  end

  describe "GET 'firefox'" do
    before { get :firefox }

    it_behaves_like 'a installer action'
  end

  describe "GET 'ie'" do
    before { get :ie }

    it_behaves_like 'a installer action'
  end

end

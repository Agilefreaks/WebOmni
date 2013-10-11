require 'spec_helper'

describe InstallationsController do
  let(:user) { mock_model(User, token: '42') }

  before do
    controller.stub(check_authentication: true)
    controller.stub(current_user: user)
  end

  shared_examples_for 'a installer action' do | action |
    before { get action }

    it { expect(response.status).to eq 200 }

    it { expect(assigns(:token)).to eq '42' }
  end

  describe "GET 'chrome'" do
    it_behaves_like 'a installer action', :chrome
  end

  describe "GET 'firefox'" do
    it_behaves_like 'a installer action', :firefox
  end

  describe "GET 'ie'" do
    it_behaves_like 'a installer action', :ie
  end

end

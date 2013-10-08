require 'spec_helper'

describe TokensController do
  let!(:user) { Fabricate(:user) }

  describe "GET 'show'" do
    before do
      controller.stub(check_authentication: true)
      controller.stub(current_user: user)
    end

    context 'when the user has an unused activation_token' do
      let(:activation_token) { Fabricate.build(:activation_token, :content => '42', :used => false) }

      before do
        user.activation_tokens.push(activation_token)
      end

      it 'it assigns the activation_token' do
        get :show
        expect(assigns(:token)).to eq '42'
      end
    end

    context "when the user doesn't have an unused token" do
      subject { get :show }

      it 'generates a new activation_token for that user' do
        # TODO: mama lui default_scope
        expect { subject }.to change { ActivationToken.count }.from(0).to(1)
      end
    end
  end
end

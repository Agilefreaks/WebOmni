require 'spec_helper'

describe TokensController do
  let!(:user) { Fabricate(:user) }

  # TODO
  # describe "GET 'show'" do
  #   before do
  #     controller.stub(check_authentication: true)
  #     controller.stub(current_user: user)
  #   end
  #
  #   context 'when the user has an unused activation_token' do
  #     let!(:activation_token) { Fabricate.build(:activation_token, :content => '42', :used => false) }
  #
  #     before do
  #       user.activation_tokens.push(activation_token)
  #     end
  #
  #     it 'it assigns the activation_token' do
  #       get :show
  #       expect(assigns(:token)).to eq '42'
  #     end
  #   end
  #
  #   context "when the user doesn't have an unused token" do
  #     let!(:activation_token) { Fabricate.build(:activation_token, :content => '42', :used => true) }
  #
  #     before do
  #       user.activation_tokens.push(activation_token)
  #     end
  #
  #     it 'generates a new activation_token for that user' do
  #       get :show
  #       expect(user.reload.activation_tokens.count).to eq 2
  #     end
  #   end
  # end
end

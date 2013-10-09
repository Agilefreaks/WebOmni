require 'spec_helper'

describe ActivationToken do
  it { should be_embedded_in(:user) }

  it { should respond_to(:content) }

  its(:type) { should eq :unknown }

  its(:used) { should eq false }

  describe 'default scope' do
    let(:user) { Fabricate(:user, activation_tokens: [Fabricate.build(:activation_token, used: true), Fabricate.build(:activation_token, used: false)]) }

    it 'only returns tokens that have not been used' do
      expect(user.activation_tokens.count).to eq 1
    end
  end
end
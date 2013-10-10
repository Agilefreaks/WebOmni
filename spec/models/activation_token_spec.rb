require 'spec_helper'

describe ActivationToken do
  it { should be_embedded_in(:user) }

  it { should respond_to(:content) }

  its(:type) { should eq :unknown }

  its(:used) { should eq false }

  describe 'unused scope' do
    let(:user) { Fabricate(:user, activation_tokens: [Fabricate.build(:activation_token, used: true), Fabricate.build(:activation_token, used: false)]) }

    subject { user.activation_tokens.unused.count }

    it { should == 1 }
  end

  describe 'first_unused scope' do
    let(:unused_activation_token) { Fabricate.build(:activation_token, content: '42', used: false) }
    let(:user) { Fabricate(:user, activation_tokens: [Fabricate.build(:activation_token, used: true), unused_activation_token]) }

    subject { user.activation_tokens.first_unused('42') }

    its(:content) { should == '42' }
  end
end
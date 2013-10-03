require 'spec_helper'

describe ActivationToken do
  it { should embed_one(:user) }

  it { expect(subject.class.method_defined?(:content)) }

  it { expect(subject.type).to eq :none }

  it { expect(subject.active?).to eq true }

  describe 'active scope' do
    let!(:expired_token) { Fabricate(:activation_token, active?: false) }
    let!(:active_token) { Fabricate(:activation_token, active?: true) }

    it 'should  only return tokens that are valid' do
      expect(ActivationToken.active.count).to eq 1
    end
  end
end
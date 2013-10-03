require 'spec_helper'

describe ActivationToken do
  it { should embed_one(:user) }

  it { expect(subject.class.method_defined?(:content)) }

  it { expect(subject.type).to eq :none }

  it { expect(subject.valid).to eq true }

  describe 'active scope' do
    let!(:expired_token) { Fabricate(:activation_token, valid: false) }
    let!(:active_token) { Fabricate(:activation_token, valid: true) }

    it 'should  only return tokens that are valid' do
      expect(ActivationToken.active.count).to eq 1
    end
  end
end
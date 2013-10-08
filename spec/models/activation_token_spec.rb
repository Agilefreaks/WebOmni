require 'spec_helper'

describe ActivationToken do
  it { expect(subject.class.method_defined?(:content)) }

  it { expect(subject.type).to eq :unknown }

  it { expect(subject.used).to eq false }

  describe 'default scope' do
    let!(:used_token) { Fabricate(:activation_token, used: true) }
    let!(:unused_token) { Fabricate(:activation_token, used: false) }

    it 'only returns tokens that have not been used' do
      expect(ActivationToken.count).to eq 1
    end
  end
end
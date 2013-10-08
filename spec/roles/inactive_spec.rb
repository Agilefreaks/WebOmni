require 'spec_helper'

describe Inactive do
  let(:activation_token) { Fabricate.build(:activation_token, content: '112233') }
  let!(:user) { Fabricate(:user, activation_tokens: [activation_token]) }

  before do
    user.extend Inactive
  end

  describe :activate do
    context 'with known and valid token' do
      it 'activates the token' do
        user.activate('112233', 'windows')
        user.reload
        # TODO: mama lui default_scope
        expect(user.activation_tokens.first.used).to eq true
      end

      #context 'with valid device type' do
      #  it 'sets the device type' do
      #    user.activate('112233', 'windows')
      #    expect(user.activation_tokens.first.type).to eq ActivationToken::TYPES['windows']
      #  end
      #end
      #
      #context 'with invalid device type' do
      #  it 'sets the unknown device type' do
      #    user.activate('112233', 'some unsupported')
      #    expect(user.activation_tokens.first.type).to eq ActivationToken::TYPES['unknown']
      #  end
      #end
    end
  end

  #describe :get_activation_token do
  #  subject { user.get_activation_token }
  #
  #  context "when the user doesn't have an unused token" do
  #
  #    before do
  #      user.activation_tokens = []
  #    end
  #
  #    it 'generates a new activation_token' do
  #      expect { subject }.to change { user.activation_tokens.count }.from(0).to(1)
  #    end
  #  end
  #
  #  context 'when the user has an unused token' do
  #    it "doesn't create a new token" do
  #      expect { subject }.to_not change { user.activation_tokens.count }
  #    end
  #
  #    it 'returns that token' do
  #      expect(subject).to eq activation_token
  #    end
  #  end
  #end
end
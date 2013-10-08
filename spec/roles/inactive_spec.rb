require 'spec_helper'

describe Inactive do
  let!(:activation_token) { Fabricate(:activation_token, content: '112233') }
  let!(:user) { Fabricate(:user, activation_tokens: [activation_token]) }

  before do
    user.extend Inactive
  end

  describe '#activate' do
    context 'with known and valid token' do
      it 'activates the token' do
        user.activate('112233', 'windows')
        expect(user.activation_tokens.first.used).to eq true
      end

      context 'with valid device type' do
        it 'sets the device type' do
          user.activate('112233', 'windows')
          expect(user.activation_tokens.first.type).to eq ActivationToken::TYPES['windows']
        end
      end

      context 'with invalid device type' do
        it 'sets the unknown device type' do
          user.activate('112233', 'some unsupported')
          expect(user.activation_tokens.first.type).to eq ActivationToken::TYPES['unknown']
        end
      end
    end
  end
end
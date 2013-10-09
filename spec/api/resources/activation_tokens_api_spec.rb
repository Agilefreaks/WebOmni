require 'spec_helper'

describe Resources::ActivationTokensAPI do
  describe "PUT 'api/v1/activation_tokens'" do
    let(:activation_token) { Fabricate.build(:activation_token, content: '112233') }
    let!(:user) { Fabricate(:user, activation_tokens: [activation_token]) }

    context 'unused activation_token is set in the body' do
      it 'is successful' do
        #noinspection RubyStringKeysInHashInspection
        put 'api/v1/activation_tokens', {'token' => '112233', 'device' => 'some_device'}
        expect(response.status).to eql 200
      end

      it 'marks the activation_token as used' do
         #noinspection RubyStringKeysInHashInspection
        put 'api/v1/activation_tokens', {'token' => '112233', 'device' => 'some_device' }
        activation_token.reload
        expect(activation_token.reload.used).to eq(true)
      end

      it 'marks the activation_token as used' do
        #noinspection RubyStringKeysInHashInspection
        put 'api/v1/activation_tokens', {'token' => '112233', 'device' => 'windows' }
        activation_token.reload
        expect(activation_token.reload.type).to eq(:windows)
      end
    end
  end
end
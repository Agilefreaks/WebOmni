require 'spec_helper'

describe Resources::ActivationTokensAPI do
  describe "PUT 'api/v1/activation_tokens'" do
    let(:activation_token) { Fabricate.build(:activation_token, content: '112233') }
    let!(:user) { Fabricate(:user, activation_tokens: [activation_token]) }

    context 'unused activation_token is set in header' do
      it 'is successful' do
        #noinspection RubyStringKeysInHashInspection
        put 'api/v1/activation_tokens', nil, {'Token' => '112233'}
        expect(response.status).to eql 200
      end

      it 'marks the activation_token as used' do
         #noinspection RubyStringKeysInHashInspection
        put 'api/v1/activation_tokens', nil, {'Token' => '112233'}
        activation_token.reload
        expect(activation_token.used).to eq(true)
      end
    end
  end
end
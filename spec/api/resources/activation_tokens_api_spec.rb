require 'spec_helper'

describe Resources::ActivationTokensAPI do
  describe "PUT 'api/v1/activation_tokens'" do
    context 'valid activation_token is set in header' do
      let!(:valid_token) { Fabricate(:activation_token, :content => '112233', :is_active => true)}
      let!(:used_token) { Fabricate(:activation_token, :content => '111111', :is_active => false)}

      it 'is successful' do
        put 'api/v1/activation_tokens', nil, {'Token' => '112233'}
        expect(response.status).to eql 200
      end

      it 'sets the valid field of the activation_token to false' do
        put 'api/v1/activation_tokens', nil, {'Token' => '112233'}
        valid_token.reload
        expect(valid_token.is_active).to eq false
      end
    end

    context 'Token sent in header is for an activation_token that is not valid anymore' do
      it 'returns 404' do
        put 'api/v1/activation_tokens', nil, { 'Token' => '111111' }
        expect(response.status).to eql  404
      end
    end
  end
end
require 'spec_helper'

describe Resources::DevicesAPI do
  describe "PUT 'api/v1/device/activate'" do
    let(:activation_token) { Fabricate.build(:activation_token, content: '112233') }
    let!(:user) { Fabricate(:user, activation_tokens: [activation_token]) }

    context 'unused activation_token is set in the body' do
      it 'is successful' do
        put 'api/v1/activation_tokens', {:'token' => '112233', :'device' => 'some_device'}
        expect(response.status).to eql 200
      end

      it 'marks the activation_token as used' do
        put 'api/v1/activation_tokens', {:'token' => '112233', :'device' => 'some_device' }
        activation_token.reload
        expect(activation_token.reload.used).to eq(true)
      end

      it 'marks the activation_token as used' do
        put 'api/v1/activation_tokens', {:'token' => '112233', :'device' => 'windows' }
        activation_token.reload
        expect(activation_token.reload.type).to eq(:windows)
      end
    end
  end

  describe "POST 'api/v1/devices'" do
    let(:options) { {:'CONTENT_TYPE' => 'application/json', :'ACCEPT' => 'application/json', :'CHANNEL' => 'token@user.com'} }
    let(:params) { {:'registrationId' => '123'} }

    it 'will call Register.device with the correct params' do
      expect(Register).to receive(:device).with('token@user.com', '123')
      post '/api/v1/devices', params.to_json, options
    end
  end

  describe "DELETE 'api/v1/devices'" do
    let(:options) { {:'CONTENT_TYPE' => 'application/json', :'ACCEPT' => 'application/json', :'CHANNEL' => 'token@user.com'} }
    let(:params) { {:'registrationId' => '123'} }

    it 'will call Unregister device with the correct params' do
      expect(Unregister).to receive(:device).with('token@user.com', '123')
      delete '/api/v1/devices', params.to_json, options
    end
  end

  describe "POST 'api/v1/devices/call'" do
    let(:options) { {:'CONTENT_TYPE' => 'application/json', :'ACCEPT' => 'application/json', :'CHANNEL' => 'token@user.com'} }

    it 'will call Call.device with the correct params' do
      expect(Call).to receive(:device).with('token@user.com', '123', 'phone_number')
      post '/api/v1/devices/call', {:'phone_number' => 'phone_number', :'registrationId' => '123'}.to_json, options
    end
  end
end
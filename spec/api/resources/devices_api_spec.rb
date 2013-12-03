require 'spec_helper'

describe Resources::DevicesAPI do
  describe "POST 'api/v1/devices'" do
    let(:options) { {:'CONTENT_TYPE' => 'application/json', :'ACCEPT' => 'application/json', :'CHANNEL' => 'token@user.com'} }
    let(:params) { {:'registrationId' => '123'} }

    it 'will call Register.device with the correct params' do
      expect(Register).to receive(:device).with('token@user.com', '123')
      post '/api/v1/devices', params.to_json, options
    end
  end

  describe "DELETE 'api/v1/devices/registration_id'" do
    let(:options) { {:'CONTENT_TYPE' => 'application/json', :'ACCEPT' => 'application/json', :'CHANNEL' => 'token@user.com'} }

    it 'will call Unregister device with the correct params' do
      expect(Unregister).to receive(:device).with('token@user.com', '123')
      delete '/api/v1/devices/123', '', options
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
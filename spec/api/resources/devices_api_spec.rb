require 'spec_helper'

describe Resources::DevicesAPI do
  describe "POST 'api/v1/devices'" do
    include_context :logged_in_as_user

    let(:options) { {:'CONTENT_TYPE' => 'application/json', :'ACCEPT' => 'application/json', :'Channel' => current_user.email} }
    let(:params) { {:'identifier' => 'Omega prime', :'name' => 'The truck'} }

    it 'will call Register.device with the correct params' do
      expect(Register).to receive(:device).with('channel' => current_user.email, 'identifier' => 'Omega prime', 'name' => 'The truck')
      post '/api/v1/devices', params.to_json, options
    end
  end

  describe "DELETE 'api/v1/devices'" do
    include_context :logged_in_as_user

    let(:options) { {:'CONTENT_TYPE' => 'application/json', :'ACCEPT' => 'application/json', :'CHANNEL' => current_user.email} }
    let(:params) { {:'registrationId' => '123'} }

    it 'will call Unregister device with the correct params' do
      expect(Unregister).to receive(:device).with(current_user.email, '123')
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
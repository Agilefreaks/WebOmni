require 'spec_helper'

describe Resources::PhonesAPI do
  describe "POST 'api/v1/phones/call'" do
    include_context :logged_in_as_user

    let(:options) { {:'CONTENT_TYPE' => 'application/json', :'ACCEPT' => 'application/json', :'Channel' => current_user.email} }
    let(:params) { {:'phone_number' => '898989'} }

    it 'will call Call.device with the correct params' do
      expect(Call).to receive(:with).with('channel' => current_user.email, 'phone_number' => '898989')
      post '/api/v1/phones/call', params.to_json, options
    end
  end
end
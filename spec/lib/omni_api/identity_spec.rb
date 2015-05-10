require 'spec_helper'

describe OmniApi::Identity do
  describe :prefix_source do
    subject { OmniApi::Identity.prefix_source }

    it { is_expected.to eq '/api/v1/users/:user_id/' }
  end

  describe :save do
    let(:identity) do
      identity = OmniApi::Identity.new
      identity.scope = 'scopes'
      identity.provider = 'Google'
      identity.expires = true
      identity.expires_at = DateTime.now
      identity.refresh_token = 'refresh_token'
      identity.token = 'token'

      identity
    end

    subject { identity.save }

    before do
      identity.user_id = '42'

      ActiveResource::HttpMock.respond_to do |mock|
        mock.post '/api/v1/users/42/identities',
                  { 'Content-Type' => 'application/json', 'Authorization' => 'bearer random' },
                  { 'scopes' =>'scopes', 'provider' => 'Google', 'expires' => true, 'expires_at' => '2015-05-10T08:33:29.977+03:00', 'refresh_token' => 'refresh_token', 'token' =>'token'}.to_json

      end
    end

    it 'saves identity properties' do
      is_expected.to be true
    end
  end
end
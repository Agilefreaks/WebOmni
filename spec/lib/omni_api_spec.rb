require 'spec_helper'

describe OmniApi do
  describe Configuration do
    it 'will prefix access token with bearer' do
      OmniApi.config.client_access_token = 'token'
      expect(OmniApi.config.client_access_token).to eq('bearer token')
    end
  end
end
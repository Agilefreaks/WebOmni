require 'spec_helper'

describe OmniApi::UserAuthorizedResource do
  describe '.headers' do
    subject { OmniApi::UserAuthorizedResource.headers }

    context 'the OmniApi config contains a user access token' do
      before { OmniApi.config.user_access_token = 'someToken' }

      its(['Authorization']) { is_expected.to eq('bearer someToken') }
    end

    context 'the OmniApi config does not contain a user access token' do
      before { OmniApi.config.user_access_token = nil }

      its(['Authorization']) { is_expected.to eq('bearer ') }
    end
  end
end
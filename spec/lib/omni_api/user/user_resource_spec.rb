require 'spec_helper'
require 'uri'

describe OmniApi::User::UserResource do
  describe '.connection' do
    subject { OmniApi::User::UserResource.connection }

    it { is_expected.to be_a(OmniApi::OmniApiConnection) }
  end

  describe '.site' do
    subject { OmniApi::User::UserResource.site }

    it { is_expected.to eq URI.parse("#{OmniApi.config.base_url}/user") }
  end
end
require 'spec_helper'

describe OmniApi::ClientAuthorizedResource do
  describe :initialize do
    let(:resource) { OmniApi::ClientAuthorizedResource.new }

    describe :attributes do
      subject { resource.attributes }

      its([:grant_type]) { is_expected.to be OmniApi::OAuth2::GrantTypes::CLIENT_CREDENTIALS }
      its([:client_id]) { is_expected.to be OmniApi.config.client_id }
      its([:client_secret]) { is_expected.to be OmniApi.config.client_secret }
    end
  end
end
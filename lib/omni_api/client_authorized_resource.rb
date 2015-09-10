require_relative 'oauth2/grant_types'

module OmniApi
  class ClientAuthorizedResource < BaseClientModel
    def initialize(attributes = {}, persisted = false)
      super
      self.attributes[:grant_type] = OmniApi::OAuth2::GrantTypes::CLIENT_CREDENTIALS
      self.attributes[:client_id] = OmniApi.config.client_id
      self.attributes[:client_secret] = OmniApi.config.client_secret
    end
  end
end
module OmniApi
  module OAuth2
    class Token < ClientAuthorizedResource
      attr_accessible :access_token, :refresh_token, :token_type, :expires_in

      self.site = "#{OmniApi.config.base_url}/oauth2/token"
    end
  end
end
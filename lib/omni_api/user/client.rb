module OmniApi
  class User
    class Client < UserAuthorizedResource
      include OmniApi::Concerns::Timestamps

      self.site = "#{OmniApi.config.base_url}/user"

      attr_accessible :id, :client_url, :client_name, :token
    end
  end
end
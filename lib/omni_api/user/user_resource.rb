module OmniApi
  class User
    class UserResource < UserAuthorizedResource
      self.site = "#{OmniApi.config.base_url}/user"
    end
  end
end
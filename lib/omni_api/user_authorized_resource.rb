module OmniApi
  class UserAuthorizedResource < BaseClientModel
    cattr_accessor :static_headers
    self.static_headers = headers

    def self.headers
      new_headers = static_headers.clone
      new_headers['Authorization'] = OmniApi.config.user_access_token
      new_headers
    end
  end
end

module OmniApi
  class UserAccessTokenFactory
    include Singleton

    def self.create(email)
      OmniApi::UserFactory.instance.create(email)
    end

    def create(email)
      OmniApi::OAuth2::Token.create(email)
    end
  end
end

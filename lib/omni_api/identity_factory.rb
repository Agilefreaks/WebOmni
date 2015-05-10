module OmniApi
  class IdentityFactory
    def self.for(user_id)
      IdentityFactory.new(user_id)
    end

    def initialize(user_id)
      @user_id = user_id
    end

    def create_from(auth_info)
      OmniApi::Identity.create(
        {
          user_id: @user_id,
          provider: auth_info.provider,
          scope: auth_info.scope,
          expires: auth_info.credentials.expires,
          expires_at: auth_info.credentials.expires_at,
          refresh_token: auth_info.credentials.refresh_token,
          token: auth_info.credentials.token
        })
    end
  end
end
class CreateAuthorizationCode
  def self.for(user)
    OmniApi::AuthorizationCode.create(user_access_token: user.access_token)
  end
end
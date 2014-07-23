class CreateAuthorizationCode
  def self.for(user_id)
    user = User.find(user_id)
    OmniApi::AuthorizationCode.create(user_access_token: user.access_token)
  end
end
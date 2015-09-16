class CreateAuthorizationCode
  def self.for(user_id)
    user = User.find(user_id)
    OmniApi::Resources::AuthorizationCode.create(email: user.email)
  end
end

class UpdateUserAccessToken
  def self.perform(user)
    self.new.perform(user)
  end

  def perform(user)
    token = OmniApi::UserAccessTokenFactory.create(user.email)
    user.access_token = token.token
    user.refresh_token = token.refresh_token
    user.access_token_expires_at = DateTime.now.utc + token.expires_in.to_i.seconds
    user.save!
  end
end
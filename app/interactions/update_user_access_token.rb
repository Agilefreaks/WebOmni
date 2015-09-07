class UpdateUserAccessToken
  def self.perform(user)
    self.new.perform(user)
  end

  def perform(user)
    token = user.refresh_token.present? ?
      OmniApi::Oauth2::Token.refresh(user.refresh_token) :
      OmniApi::Oauth2::Token.create_for(user.email)
    user.access_token = token.access_token
    user.refresh_token = token.refresh_token
    user.access_token_expires_at = DateTime.now.utc + token.expires_in.to_i.seconds
    user.save
  end
end
class UpdateUserIdentity
  def self.perform(user, params)
    self.new.perform(user, params)
  end

  def perform(user, params)
    user.identity.update(sanitize_params(params))
  end

  private

  def sanitize_params(params)
    {
      provider: params.provider,
      scope: params.scope,
      expires: params.credentials.expires,
      expires_at: params.credentials.expires_at,
      refresh_token: params.credentials.refresh_token,
      token: params.credentials.token
    }
  end
end
class CalendarsApi < GoogleApi
  private

  def api
    @google_api_client.discovered_api('calendar', 'v3')
  end

  def credentials_for(user)
    authorization = {
      access_token: user.identity.token,
      refresh_token: user.identity.refresh_token,
      expires_at: user.identity.expires_at
    }

    @authorization ||= (
    auth = @google_api_client.authorization.dup
    auth.update_token!(authorization)
    auth
    )
  end
end

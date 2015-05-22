class CalendarsApi
  def initialize
    @api_client = GoogleApi.new
  end

  private

  def api
    @api_client.discovered_api('calendar', 'v3')
  end

  def credentials_for(user)
    authorization = {
      access_token: user.identity.token,
      refresh_token: user.identity.refresh_token,
      expires_at: user.identity.expires_at
    }

    @authorization ||= (
    auth = @api_client.authorization.dup
    auth.update_token!(authorization)
    auth
    )
  end
end

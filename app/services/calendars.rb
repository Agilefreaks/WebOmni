class Calendars
  def initialize(api_client)
    @api_client = api_client
  end

  def list(user)
    result = @api_client.execute(api_method: calendar_api.calendar_list.list, parameters: {}, authorization: credentials(user))

    result.data['items']
  end

  def watch(calendar)
    request = @api_client.execute(
      api_method: calendar_api.events.watch,
      parameters: { calendarId: calendar.google_id },
      body_object: calendar.notification_channel.to_params,
      authorization: credentials(calendar.user))



    request.data
  end

  private

  def credentials(user)
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

  def calendar_api
    @api_client.discovered_api('calendar', 'v3')
  end
end
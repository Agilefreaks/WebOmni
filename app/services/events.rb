class Events < CalendarsApi
  def get(user, calendar_id, event_id)
    result = @api_client.execute(api_method: api.events.get, parameters: {'calendarId' => calendar_id, 'event_id' => event_id}, authorization: credentials_for(user))

    result.data
  end
end
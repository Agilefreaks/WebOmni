class CalendarList < CalendarsApi
  def list(user)
    result = @google_api_client.execute(api_method: api.calendar_list.list, parameters: {}, authorization: credentials_for(user))

    result.data['items']
  end

  def watch(calendar)
    request = @google_api_client.execute(
      api_method: api.events.watch,
      parameters: { calendarId: calendar.google_id },
      body_object: calendar.notification_channel.to_params,
      authorization: credentials_for(calendar.user))

    request.data
  end
end

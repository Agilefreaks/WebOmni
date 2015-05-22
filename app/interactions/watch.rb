class Watch
  def self.calendar(calendar, callback_url)
    Watch.new(calendar, callback_url).start
  end

  def initialize(calendar, callback_url)
    @calendar = calendar
    @callback_url = callback_url
    @calendars_api = GoogleApi.new.calendars
  end

  def start
    notification_channel = @calendar.renew_notification_channel
    response = @calendars_api.watch(@calendar)

    notification_channel.expiration = DateTime.strptime(response['expiration'].to_s, '%Q')
    @calendar.watched = response['id'] == notification_channel.id
    @calendar.save
  end
end
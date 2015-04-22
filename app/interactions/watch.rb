class Watch
  def self.calendar(calendar, callback_url)
    Watch.new(calendar, callback_url).perform
  end

  def initialize(calendar, callback_url)
    @calendar = calendar
    @callback_url = callback_url
    @calendars_api = CalendarList.new
  end

  def perform
    notification_channel = @calendar.renew_notification_channel(@callback_url)
    response = @calendars_api.watch(@calendar)
    notification_channel.expiration = DateTime.strptime(response['expiration'].to_s, '%Q')
    @calendar.watched = response['id'] == notification_channel.uuid
    @calendar.save
  end
end
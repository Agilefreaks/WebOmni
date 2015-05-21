class Watch
  def self.calendar(calendar, callback_url)
    Watch.new(calendar, callback_url).start
  end

  def initialize(calendar, callback_url)
    @calendar = calendar
    @callback_url = callback_url
    @calendars_api = Google::Api.new.calendars
  end

  def start
    @calendar.notification_channel = NotificationChannel.new(@callback_url)
    @calendar.watched = @calendars_api.watch(@calendar)
    @calendar.save
  end
end
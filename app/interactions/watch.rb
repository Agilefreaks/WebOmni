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
    @calendar.renew_notification_channel
    @calendar.watched = @calendars_api.watch(@calendar)
    @calendar.save
  end
end
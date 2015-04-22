class Calendars::Notifications::FindUser < UseCase::Base
  def before
    @channel_id = context.send('X-Goog-Channel-ID')
  end

  def perform
    notification_channel = NotificationChannel.where(uuid: @channel_id).first
    if notification_channel.nil?
      failure(:notification_channel, "No channel found with uuid = #{@channel_id}")
    else
      calendar = notification_channel.calendar
      context.calendar = calendar
      context.user = calendar.user
    end
  end
end
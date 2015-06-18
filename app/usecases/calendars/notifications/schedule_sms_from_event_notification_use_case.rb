#When a notifications is posted from Google, we should schedule a SMS message to the user that is the owner of the calendar

module Calendars
  module Notifications
    class ScheduleSMSFromEventNotificationUseCase < UseCase::Base
      depends VerifyState, EnsureEvent, FindUser, GetEvent, ScheduleSMS
    end
  end
end

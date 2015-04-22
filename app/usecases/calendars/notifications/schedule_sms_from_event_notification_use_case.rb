#When a notifications is posted from Google, we should schedule a SMS message to the user that is the owner of the calendar

class ScheduleSMSFromEventNotificationUseCase < UseCase::Base
  depends VerifyState, EnsureEvent, FindUser, GetEvent, ScheduleSMS
end
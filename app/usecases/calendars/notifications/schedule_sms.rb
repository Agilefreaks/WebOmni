module Calendars
  module Notifications
    class ScheduleSMS < UseCase::Base
      def before
        @event = context.event
        @first_name, @phone_number = @event.summary.delete(' ').split('-')
        @message = "Hello #{@first_name}"
        @send_at = 5.minutes.from_now
      end

      def perform
        sms_message = OmniApi::Resources::SmsMessage.schedule(phone_number: @phone_number,
                                                              content: @message,
                                                              send_at: @send_at)

        sms_message.save
      end
    end
  end
end

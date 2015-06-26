module Calendars
  module Notifications
    class GetEvent < UseCase::Base
      def before
        @events_api = Events.new
        @event_id = context.send('X-Goog-Resource-ID')
        @calendar = context.calendar
        @user = context.user
      end

      def perform
        context.event = @events_api.get(@user, @calendar.google_id, @event_id)

        failure(:get_event, "An event with id #{@event_id} was not found") if context.event.nil?
      end
    end
  end
end

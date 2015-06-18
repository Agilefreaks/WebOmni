module Calendars
  module Notifications
    class VerifyState < UseCase::Base
      def before
        @state = context.send('X-Goog-Resource-State')
      end

      def perform
        stop! unless @state == 'exists'
      end
    end
  end
end

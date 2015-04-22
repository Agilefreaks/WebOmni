class Calendars::Notifications::VerifyState < UseCase::Base
  def before
    @state = context.send('X-Goog-Resource-State')
  end

  def perform
    stop! unless @state == 'exists'
  end
end
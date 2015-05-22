class Calendars::Notifications::EnsureEvent < UseCase::Base
  def before
    @resource_uri = context.send('X-Goog-Resource-URI')
  end

  def perform
    stop! unless @resource_uri.end_with?('/events')
  end
end
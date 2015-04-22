require 'google/api_client'
require 'google/api_client/client_secrets'

class CalendarsController < DashboardController
  before_action :authorize_calendar_access, only: :index

  before_action :sync_calendars, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :request_calendar_access

  def index
    @calendars = current_user.calendars

    render
  end

  def watch
    calendar = Calendar.find(params[:id])
    Watch.calendar(calendar, notifications_calendars_url)

    redirect_to calendars_path
  end

  def notifications
    context = ScheduleSMSFromEventNotificationUseCase.perform(headers)
    status = context.success? ? :ok : :internal_server_error

    render nothing: true, status: status
  end

  private

  def authorize_calendar_access
    authorize :calendar, :show?
  end

  def request_calendar_access
    session[:google_permissions] = 'calendar.readonly'

    redirect_to user_omniauth_authorize_path(:google_oauth2, origin: calendars_path)
  end

  def sync_calendars
    SyncCalendars.for(current_user)
  end
end
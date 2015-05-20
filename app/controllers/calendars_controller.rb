class CalendarsController < DashboardController
  before_action :authorize_calendar_access, only: :show

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def show
    render
  end

  private

  def authorize_calendar_access
    authorize :calendar, :show?
  end

  def user_not_authorized
    session[:google_permissions] = 'calendar.readonly'

    redirect_to user_omniauth_authorize_path(:google_oauth2, origin: calendars_path)
  end
end
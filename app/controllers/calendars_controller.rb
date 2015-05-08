class CalendarsController < DashboardController
  before_action :authorize_calendar_access, only: :show
  def show
    render
  end

  private

  def authorize_calendar_access
    unless user_signed_in? && current_user.has_access? then
      session[:google_permissions] = 'calendar.readonly'

      redirect_to user_omniauth_authorize_path(:google_oauth2, origin: calendars_path)
    end
  end
end
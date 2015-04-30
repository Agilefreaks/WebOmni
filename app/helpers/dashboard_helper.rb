module DashboardHelper
  def current_api_user
    return unless current_user

    @current_api_user ||= OmniApi::User.where(email: current_user.email).first
  end

  def show_calendars_path
    if user_signed_in? && current_user.has_calendar_access? then
      calendars_path
    else
      session[:google_permissions] = 'calendar.readonly'
      user_omniauth_authorize_path(:google_oauth2, origin: calendars_path)
    end
  end
end
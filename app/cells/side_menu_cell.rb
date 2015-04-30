class SideMenuCell < Cell::Rails
  include Devise::Controllers::Helpers
  include DashboardHelper

  helper_method :user_signed_in?, :current_user, :current_api_user, :show_calendars_path

  def show
    render
  end
end

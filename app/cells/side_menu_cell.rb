class SideMenuCell < Cell::ViewModel
  include Devise::Controllers::Helpers
  include DashboardHelper
  include Pundit

  helper_method :user_signed_in?, :current_user, :current_api_user, :show_calendars_path, :policy

  def show
    render
  end

  def pundit_user
    current_api_user
  end
end

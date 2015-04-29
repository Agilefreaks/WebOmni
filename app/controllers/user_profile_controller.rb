class UserProfileController < DashboardController
  def show
    @current_api_user = OmniApi::User.where(email: current_user.email).first

    render
  end
end
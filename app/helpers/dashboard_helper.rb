module DashboardHelper
  def current_api_user
    return unless current_user

    @current_api_user ||= OmniApi::User.where(email: current_user.email).first
  end
end

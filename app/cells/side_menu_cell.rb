class SideMenuCell < Cell::Rails
  include Devise::Controllers::Helpers

  helper_method :user_signed_in?, :current_user

  def show
    @current_api_user = OmniApi::User.where(email: current_user.email).first

    render
  end

end

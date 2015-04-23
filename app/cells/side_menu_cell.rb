class SideMenuCell < Cell::Rails
  include Devise::Controllers::Helpers

  helper_method :user_signed_in?, :current_user

  def show
    render
  end

end
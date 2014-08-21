class MenuCell < Cell::Rails
  include Devise::Controllers::Helpers
  include PagesHelper

  helper_method :download_path, :user_signed_in?, :current_user

  def show
    @menu = user_signed_in? ? 'authorized' : 'unauthorized'
    render
  end
end

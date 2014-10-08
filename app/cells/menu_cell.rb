class MenuCell < Cell::Rails
  include Devise::Controllers::Helpers
  include PagesHelper

  helper_method :download_path, :user_signed_in?, :current_user

  def show(params)
    @is_mobile_device = params[:is_mobile_device?]
    @menu = user_signed_in? ? 'authorized' : 'unauthorized'
    render
  end

  def is_mobile_device?
    @is_mobile_device
  end
end

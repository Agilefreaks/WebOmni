class MenuCell < Cell::ViewModel
  include PagesHelper
  include AbstractController::Translation

  helper_method :download_path

  builds do |model, _options|
    model ? AuthorizedMenuCell : UnauthorizedMenuCell
  end

  def mobile_device?
    options[:mobile_device]
  end

  def user_signed_in?
    !model.nil?
  end
end

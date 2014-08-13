module PagesHelper
  def download_path(user_signed_in)
    user_signed_in ? new_download_path : user_omniauth_authorize_path(:google_oauth2, origin: new_download_path)
  end
end

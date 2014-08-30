module PagesHelper
  def download_path(user_signed_in)
    user_signed_in ? new_download_path(download: true) : user_omniauth_authorize_path(:google_oauth2, origin: new_download_path(download: true))
  end

  def authorization_code
    @authorization_code.code if defined? @authorization_code
  end

  def custom_call_path(user_signed_in, phone_number)
    actual_call_path = call_path(phone_number: phone_number)
    user_signed_in ? actual_call_path : user_omniauth_authorize_path(:google_oauth2, origin: actual_call_path)
  end
end

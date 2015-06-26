module PagesHelper
  def download_path
    download_path = if is_mobile_device?
                      android_download_path
                    else
                      new_download_path(download: true)
                    end

    user_signed_in? ? download_path : user_omniauth_authorize_path(:google_oauth2, origin: download_path)
  end

  def authorization_code
    @authorization_code.code if defined? @authorization_code
  end

  def custom_call_path(user_signed_in, phone_number)
    actual_call_path = call_path(phone_number: phone_number)
    user_signed_in ? actual_call_path : user_omniauth_authorize_path(:google_oauth2, origin: actual_call_path)
  end

  private

  def android_download_path
    user_signed_in? ? android_client_downloads_path(email:  @current_user.email) : android_client_downloads_path
  end
end

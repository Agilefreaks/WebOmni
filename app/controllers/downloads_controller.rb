require 'open-uri'

class DownloadsController < ApplicationController
  def new
    NotificationsMailer.welcome(current_user.id).deliver if user_signed_in?

    redirect_to root_url(download: true)
  end

  def windows_client
    redirect_to(root_url(download: true)) && return unless user_signed_in?

    @authorization_code = CreateAuthorizationCode.for(current_user)
    data = open(WINDOWS_CLIENT_DOWNLOAD_LINK)
    filename = File.basename(WINDOWS_CLIENT_DOWNLOAD_LINK, '.*')

    Track.windows_download(current_user.email)

    send_data data.read, filename: "#{filename}#{@authorization_code.code}.msi"
  end

  def android_client
    current_user = find_current_user
    @authorization_code = CreateAuthorizationCode.for(current_user)

    Track.android_download(current_user.email)

    redirect_to ANDROID_CLIENT_DOWNLOAD_LINK
  end

  private

  def find_current_user
    if user_signed_in?
      current_user
    else
      User.find_by(email: params[:email])
    end
  end
end

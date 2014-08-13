require 'open-uri'

class DownloadsController < ApplicationController
  before_action :authenticate!, except: :android_client

  def new
    NotificationsMailer.welcome(current_user.id).deliver
    redirect_to root_url(download: true), notice: 'Your download will start any moment.'
  end

  def windows_client
    @authorization_code = CreateAuthorizationCode.for(current_user)
    data = open(WINDOWS_CLIENT_DOWNLOAD_LINK)
    filename = File.basename(WINDOWS_CLIENT_DOWNLOAD_LINK, ".*")
    send_data data.read, :filename => "#{filename}#{@authorization_code.code}.exe"
  end

  def android_client
    @authorization_code = CreateAuthorizationCode.for(find_current_user)
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
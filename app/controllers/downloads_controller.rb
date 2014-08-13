require 'open-uri'

class DownloadsController < ApplicationController
  before_action :authenticate!

  def new
    redirect_to root_url(download: true), notice: 'Your download will start any moment.'
  end

  def windows_client
    @authorization_code = CreateAuthorizationCode.for(current_user)
    data = open(WINDOWS_CLIENT_DOWNLOAD_LINK)
    filename  = File.basename(WINDOWS_CLIENT_DOWNLOAD_LINK,".*")
    send_data data.read, :filename => "#{filename}#{@authorization_code.code}.exe"
  end
end
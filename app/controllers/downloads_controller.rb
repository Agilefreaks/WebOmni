class DownloadsController < ApplicationController
  before_action :check_authentication

  def index
  end

  def windows
    @token = ActivationService.new.get_activation_token(current_user.id).content
    data = open(WINDOWS_CLIENT_DOWNLOAD_LINK)
    send_data data.read, :filename => "OmnipasteSetup-#{@token.content}.exe"
  end
end
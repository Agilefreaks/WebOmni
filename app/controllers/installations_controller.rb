class InstallationsController < ApplicationController
  before_action :check_authentication, :populate_token

  respond_to :html

  def chrome
    respond_with @token
  end

  def firefox
    respond_with @token
  end

  def ie
    respond_with @token
  end

  private

  def populate_token
    @token = current_user.token
  end
end

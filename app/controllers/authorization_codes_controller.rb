class AuthorizationCodesController < ApplicationController
  before_action :authenticate!

  respond_to :js

  def create
    @authorization_code = OmniApi::AuthorizationCode.create(user_access_token: current_user.access_token)
  end
end

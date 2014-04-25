class AuthorizationCodesController < ApplicationController
  before_action :authenticate!

  respond_to :js

  def create
    @authorization_code = AuthorizationCode.create(user_id: current_user.id)
  end
end

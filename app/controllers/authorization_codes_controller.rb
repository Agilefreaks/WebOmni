class AuthorizationCodesController < ApplicationController
  before_action :authenticate!

  respond_to :js

  def create
    @authorization_code = CreateAuthorizationCode.for(current_user)
  end
end

class AuthorizationCodesController < ApplicationController
  include Devise::Controllers::Helpers

  before_action :authenticate!

  respond_to :js

  def create
    @authorization_code = CreateAuthorizationCode.for(current_user)
  rescue ActiveResource::ServerError => e
    sign_out(User)

    flash[:notice] = 'Please log back in. We closed your current session.'
    flash.keep(:notice)

    js_redirect_to(root_path)
  end
end

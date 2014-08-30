class AuthorizationCodesController < ApplicationController
  include Devise::Controllers::Helpers

  def new
    if user_signed_in?
      @authorization_code = create_authorization_code(current_user)
      render :new, layout: 'presentation'
    else
      redirect_to user_omniauth_authorize_path(:google_oauth2, origin: new_authorization_codes_path)
    end
  end

  private

  def create_authorization_code(current_user)
    CreateAuthorizationCode.for(current_user.id)
  rescue ActiveResource::ServerError => _
    sign_out(User)

    flash[:notice] = 'Please log back in. We closed your current session.'
    flash.keep(:notice)

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { js_redirect_to(root_path) }
    end
  end
end

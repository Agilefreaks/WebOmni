class AuthorizationCodesController < ApplicationController
  include Devise::Controllers::Helpers

  def new
    if user_signed_in?
      create_authorization_code(current_user)
    else
      redirect_to user_omniauth_authorize_path(:google_oauth2, origin: new_authorization_codes_path)
    end
  end

  private

  # rubocop:disable Metrics/MethodLength
  def create_authorization_code(current_user)
    Track.create_authorization_code(current_user.email)
    @authorization_code = CreateAuthorizationCode.for(current_user.id)
    respond_to do |format|
      format.html { render layout: 'dashboard' }
    end
  rescue ActiveResource::ServerError => _
    sign_out(User)

    flash_notice('Please log back in. We closed your current session.')

    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

  def flash_notice(text)
    flash[:notice] = text
    flash.keep(:notice)
  end
end

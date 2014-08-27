class AuthorizationCodesController < ApplicationController
  include Devise::Controllers::Helpers

  before_action :authenticate!

  respond_to :js, only: [:create]

  def new
    @authorization_code = create_authorization_code(current_user)
    render :new, layout: 'presentation'
  end

  def create
    @authorization_code = create_authorization_code(current_user)
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

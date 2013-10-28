class PagesController < ApplicationController
  def free
    redirect_to user_omniauth_authorize_path(:google_oauth2)
  end
end
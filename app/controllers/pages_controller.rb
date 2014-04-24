class PagesController < ApplicationController
  def welcome
    render :welcome
  end

  def free
    redirect_to user_omniauth_authorize_path(:google_oauth2)
  end
end
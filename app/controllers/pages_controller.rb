class PagesController < ApplicationController
  def welcome
  end

  def pricing
  end

  def free
    redirect_to user_omniauth_authorize_path(:google_oauth2, state: @state)
  end

  def about
  end

  def team
  end

  def contact
  end
end

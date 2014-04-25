class PagesController < ApplicationController
  def welcome
    render user_signed_in? ? :welcome_signed_in : :welcome
  end
end
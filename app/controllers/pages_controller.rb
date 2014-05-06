class PagesController < ApplicationController
  def welcome
    render user_signed_in? ? :welcome_signed_in : :welcome
  end

  def contact
  end

  def call
    OmniApi::Phones::Call.for(current_user).with(params[:phone_number])

    respond_to do |format|
      format.js {}
    end
  end
end
class PagesController < ApplicationController

  def welcome
    render (user_signed_in? ? :welcome_signed_in : :welcome), layout: 'presentation'
  end

  def call
    phone_number = params[:phone_number]
    OmniApi::Devices::Call.for(current_user).with(phone_number)

    redirect_to root_path, notice: "Pick up your phone, it's calling #{phone_number}"
  end
end

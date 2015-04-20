class PagesController < ApplicationController
  before_action :authenticate!, only: :call

  layout 'embedable', only: ['get_user_token']

  def welcome
    page = user_signed_in? ? :welcome_signed_in : :welcome
    render page, layout: 'presentation'
  end

  def call
    phone_number = params[:phone_number]
    OmniApi::PhoneCalls.new.create(current_user.access_token, phone_number)

    redirect_to root_path, notice: "Pick up your phone, it's calling #{phone_number}"
  end

  def get_user_token
    page = user_signed_in? ? :welcome_signed_in : :welcome
    render page
  end
end

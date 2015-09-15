class PagesController < ApplicationController
  before_action :authenticate!, only: [:call, :user_access_token]

  def welcome
    page = user_signed_in? ? :welcome_signed_in : :welcome
    render page, layout: 'presentation'
  end

  def call
    phone_number = params[:phone_number]
    OmniApi::Resources::PhoneCall.new(number: phone_number,
                           type: 'outgoing',
                           state: 'starting').save

    redirect_to root_path, notice: "Pick up your phone, it's calling #{phone_number}"
  end

  def user_access_token
    @user_access_token = current_user.access_token
    render :user_access_token, layout: 'embedable'
  end
end

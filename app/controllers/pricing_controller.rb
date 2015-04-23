class PricingController < ApplicationController
  layout 'dashboard'

  def show
    render
  end

  def change
    current_user.plan = params[:plan] || current_user.plan
    current_user.save!
    redirect_to user_path
  end
end
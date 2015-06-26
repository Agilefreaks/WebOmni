class PricingController < DashboardController
  def show
    render
  end

  def change
    ModifyPricingPlan.for(current_user.email).to(params[:plan])

    redirect_to user_path
  end
end

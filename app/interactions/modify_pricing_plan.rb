class ModifyPricingPlan
  def self.for(email)
    ModifyPricingPlan.new(email)
  end

  def to(new_plan)
    api_user = OmniApi::User.where(email: @email).first
    api_user.plan = new_plan || api_user.plan

    api_user.save!
  end

  def initialize(email)
    @email = email
  end
end
class ModifyPricingPlan
  def self.for(email)
    ModifyPricingPlan.new(email)
  end

  def initialize(email)
    @email = email
  end

  def to(new_plan)
    OmniApi::Resources::User.change_plan!(@email, new_plan)
  end
end

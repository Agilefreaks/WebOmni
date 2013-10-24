class PricingController < ApplicationController
  def index
  end

  def show
    @plan = request.path[1..-1]
  end
end

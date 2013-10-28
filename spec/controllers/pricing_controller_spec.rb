require 'spec_helper'

describe PricingController do
  describe :show do
    before :each do
      request.stub(path: '/pricing_plan')
      get :show
    end

    it 'assigns plan to the request path' do
      expect(assigns(:plan)).to eq 'pricing_plan'
    end
  end
end

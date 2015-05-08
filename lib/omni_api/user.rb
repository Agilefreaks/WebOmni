module OmniApi
  class User < BaseClientModel
    include Concerns::Timestamps

    attr_accessible :first_name, :last_name, :access_token, :plan

    def self.change_plan!(email, plan)
      put plan.to_s, [], {email: email}.to_json

      return
    end
  end
end

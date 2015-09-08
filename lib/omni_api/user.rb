module OmniApi
  class User < BaseClientModel
    include Concerns::Timestamps

    attr_accessible :first_name, :last_name, :access_token, :refresh_token, :plan, :access_token_expires_at

    def self.change_plan!(email, plan)
      put plan.to_s, [], { email: email }.to_json
    end
  end
end

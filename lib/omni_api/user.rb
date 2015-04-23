module OmniApi
  class User < BaseClientModel
    include Concerns::Timestamps

    attr_accessible :id, :first_name, :last_name, :access_token, :plan
  end
end

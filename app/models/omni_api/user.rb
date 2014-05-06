module OmniApi
  class User < BaseClientModel
    include Concerns::Timestamps

    attr_accesible :id, :first_name, :last_name, :access_token
  end
end
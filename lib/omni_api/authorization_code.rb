module OmniApi
  class AuthorizationCode < BaseClientModel
    include Concerns::Timestamps

    attr_accessible :id, :code
  end
end

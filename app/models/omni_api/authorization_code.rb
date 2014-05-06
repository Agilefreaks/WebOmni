module OmniApi
  class AuthorizationCode < BaseClientModel
    include Concerns::Timestamps

    attr_accesible :id, :code
  end
end
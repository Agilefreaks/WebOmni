class AuthorizationCode < ClientApiModel
  include Concerns::Timestamps

  attr_accesible :id, :code
end
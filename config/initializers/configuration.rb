class Configuration
  class << self
    attr_accessor :client_id
    attr_accessor :client_access_token
  end

  @client_access_token = "bearer #{CLIENT_ACCESS_TOKEN}"
end
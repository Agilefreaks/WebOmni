require 'singleton'

module OmniApi
  class Configuration
    include Singleton

    attr_accessor :test_mode, :client_access_token, :base_url

    def client_access_token=(token)
      @client_access_token = "bearer #{token}"
    end
  end

  def self.config
    Configuration.instance
  end
end
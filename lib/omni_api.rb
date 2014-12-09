require 'singleton'

module OmniApi
  mattr_accessor :test_mode
  self.test_mode = false

  mattr_accessor :client_access_token
  self.client_access_token = ''

  def self.client_access_token=(token)
    @@client_access_token = "bearer #{token}"
  end

  mattr_accessor :base_url
  self.client_access_token = ''

  def self.config
    self
  end

  def self.setup
    yield self
  end
end
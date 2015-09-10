require 'singleton'

module OmniApi
  mattr_accessor :test_mode
  self.test_mode = false

  mattr_accessor :client_access_token
  self.client_access_token = ''

  mattr_accessor :client_id
  self.client_id = ''

  mattr_accessor :client_secret
  self.client_secret = ''

  # rubocop:disable Style/ClassVars
  def self.client_access_token=(token)
    @@client_access_token = "bearer #{token}"
  end

  mattr_accessor :user_access_token
  self.user_access_token = ''

  # rubocop:disable Style/ClassVars
  def self.user_access_token=(token)
    @@user_access_token = "bearer #{token}"
  end

  mattr_accessor :base_url
  self.base_url = ''

  def self.config
    self
  end

  def self.setup
    yield self
  end
end

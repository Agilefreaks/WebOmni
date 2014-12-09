module TrackConfig
  mattr_accessor :test_mode
  self.test_mode = false

  mattr_accessor :api_key
  self.api_key = ''

  def self.config
    yield self
  end
end

TrackConfig.config do |conf|
  conf.api_key = 'd4a302f695330322fe4c44bc302f3780' if Rails.env.staging? || Rails.env.production?
  conf.test_mode = Rails.env.test? || Rails.env.cucumber? || Rails.env.development?
end
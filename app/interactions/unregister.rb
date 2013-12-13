class Unregister
  def self.device(params)
    Unregister.new(params['channel'], params['identifier']).execute
  end

  attr_accessor :channel, :identifier

  def initialize(channel, identifier)
    @channel = channel
    @identifier = identifier
  end

  def execute
    user = User.find_by(email: @channel)
    device = user.registered_devices.find_by(identifier: @identifier)
    device.destroy
  end
end
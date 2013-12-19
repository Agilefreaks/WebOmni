class DeactivateDevice
  def self.with(params)
    DeactivateDevice.new(params['channel'], params['identifier']).execute
  end

  attr_reader :channel, :identifier

  def initialize(channel, identifier)
    @channel = channel
    @identifier = identifier
  end

  def execute
    user = User.find_by(email: channel)
    registered_device = user.registered_devices.find_by(identifier: @identifier)
    registered_device.update_attribute(:registration_id, nil)
    registered_device
  end
end
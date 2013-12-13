class ActivateDevice
  def self.with(params)
    ActivateDevice.new(params['channel'], params['identifier'], params['registration_id']).execute
  end

  attr_reader :channel, :identifier, :registration_id

  def initialize(channel, identifier, registration_id)
    @channel = channel
    @identifier = identifier
    @registration_id = registration_id
  end

  def execute
    user = User.find_by(email: channel)
    registered_device = user.registered_devices.find_by(identifier: @identifier)
    registered_device.update_attribute(:registration_id, @registration_id)
    registered_device
  end
end
class ActivateDevice
  def self.with(params)
    ActivateDevice.new(params['channel'], params['identifier'], params['registration_id'], params['provider']).execute
  end

  attr_reader :channel, :identifier, :registration_id, :provider

  def initialize(channel, identifier, registration_id, provider)
    @channel = channel
    @identifier = identifier
    @registration_id = registration_id
    @provider = provider
  end

  def execute
    user = User.find_by(email: @channel)
    registered_device = user.registered_devices.find_by(identifier: @identifier)
    registered_device.update_attributes({ :registration_id => @registration_id, :provider => @provider })
    registered_device
  end
end
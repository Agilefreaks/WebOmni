class Register
  def self.device(params)
    Register.new(params['channel'], params['identifier'], params['name']).execute
  end

  attr_accessor :channel, :identifier, :name

  def initialize(channel, identifier, name)
    @channel = channel
    @identifier = identifier
    @name = name
  end

  def execute
    user = User.find_by(email: @channel)

    registered_device = user.registered_devices.find_or_initialize_by(:identifier => @identifier)
    registered_device.name = name
    registered_device.save!

    registered_device
  end
end
class Unregister
  def self.device(channel, registration_id)
    Unregister.new(channel, registration_id).execute
  end

  attr_accessor :channel, :registration_id

  def initialize(channel, registration_id)
    @channel = channel
    @registration_id = registration_id
  end

  def execute
    user = User.find_by(email: @channel)
    device = user.devices.find_by(registration_id: @registration_id)
    device.destroy
  end
end
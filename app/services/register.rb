class Register
  def self.device(channel, registration_id)
    Register.new(channel, registration_id).execute
  end

  attr_accessor :channel, :registration_id

  def initialize(channel, registration_id)
    @channel = channel
    @registration_id = registration_id
  end

  def execute
    User.find_by(email: @channel).
        devices.
        find_or_create_by(registration_id: @registration_id)
  end
end
class Call
  def self.with(params)
    Call.new(params['channel'], params['phone_number']).execute
  end

  attr_accessor :channel, :phone_number
  attr_accessor :notification_service

  def initialize(channel, phone_number)
    @channel = channel
    @phone_number = phone_number
  end

  def execute
    user = User.find_by(email: channel)

    @notification_service ||= NotificationService.new
    @notification_service.notify(PhoneNumber.new(user: user, content: phone_number), '')
  end
end
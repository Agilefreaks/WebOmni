class Call
  def self.device(token, from_registration_id, phone_number)
    Call.new(token, from_registration_id, phone_number).execute
  end

  attr_accessor :token, :from_registration_id, :phone_number

  def initialize(token, from_registration_id, phone_number)
    @token = token
    @from_registration_id = from_registration_id
    @phone_number = phone_number
  end

  def execute
    user = User.find_by(email: token)

    gcm = GCM.new('AIzaSyDiX6YE0kjKmnjSygNRC_sYq6MBUfzsg2I')

    options = {data: {registration_id: from_registration_id, phone_number: phone_number}, collapse_key: 'phone'}
    gcm.send_notification(user.devices.map(&:registration_id), options) if user.devices.any?
  end
end
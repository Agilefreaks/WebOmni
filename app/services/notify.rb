class Notify
  def self.user(token, from_registration_id)
    Notify.new(token, from_registration_id).execute
  end

  attr_accessor :token, :from_registration_id

  def initialize(token, from_registration_id)
    @token = token
    @from_registration_id = from_registration_id
  end

  def execute
    user = User.find_by(email: token)

    gcm = GCM.new('AIzaSyDiX6YE0kjKmnjSygNRC_sYq6MBUfzsg2I')

    options = {data: {registration_id: from_registration_id}, collapse_key: 'clipboard'}
    gcm.send_notification(user.devices.map(&:registration_id), options) if user.devices.any?
  end
end
class NotificationService
  attr_accessor :gcm

  def notify(clipping)
    @gcm ||= GCM.new(WebOmni::Application::GOOGLE_API_KEY)

    user = clipping.user

    options = {data: {registration_id: 'other'}, collapse_key: 'clipboard'}
    @gcm.send_notification(user.registered_devices.map(&:registration_id), options) if user.registered_devices.any?
  end
end
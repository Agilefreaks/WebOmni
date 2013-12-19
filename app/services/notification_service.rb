class NotificationService
  attr_accessor :gcm

  def notify(model)
    self.send(model.class.to_s.underscore.to_sym, model)
  end

  def clipping(model)
    options = {data: {registration_id: 'other'}, collapse_key: 'clipboard'}
    gcm_send(model.user, options)
  end

  def phone_number(model)
    options = {data: {registration_id: 'other', phone_number: model.content}, collapse_key: 'call'}
    gcm_send(model.user, options)
  end

  private

  def gcm_send(user, options)
    @gcm ||= GCM.new(WebOmni::Application::GOOGLE_API_KEY)
    @gcm.send_notification(user.registered_devices.active.map(&:registration_id), options) if user.registered_devices.active.any?
  end
end
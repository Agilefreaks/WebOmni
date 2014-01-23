class NotificationService
  attr_accessor :gcm

  def notify(model, source_identifier)
    self.send(model.class.to_s.underscore.to_sym, model, source_identifier)
  end

  def clipping(model, source_identifier)
    options = {data: {registration_id: 'other'}, collapse_key: 'clipboard'}
    gcm_send(model.user, source_identifier, options)
  end

  def phone_number(model, source_identifier)
    options = {data: {registration_id: 'other', phone_number: model.content}, collapse_key: 'call'}
    gcm_send(model.user, source_identifier, options)
  end

  private

  def gcm_send(user, source_identifier, options)
    @gcm ||= GCM.new(WebOmni::Application::GOOGLE_API_KEY)
    devices_to_notify = user.registered_devices.active.where(:identifier.ne => source_identifier)
    @gcm.send_notification(devices_to_notify.map(&:registration_id), options) if devices_to_notify.any?
  end
end
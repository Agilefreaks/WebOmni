class NotificationService
  attr_accessor :gcm
  attr_accessor :omni_notification_service

  def notify(model, source_identifier)
    self.send(model.class.to_s.underscore.to_sym, model, source_identifier)
  end

  def clipping(model, source_identifier)
    options = {data: {}, collapse_key: 'clipboard'}
    user = model.user
    user.registered_devices.active.where(:identifier.ne => source_identifier).group_by(&:provider).each do |key, group|
      self.send((key.to_s + '_send').to_sym, group.map(&:registration_id), options)
    end
  end

  def phone_number(model, source_identifier)
    options = {data: {registration_id: 'other', phone_number: model.content}, collapse_key: 'call'}
    user = model.user
    user.registered_devices.active.where(:identifier.ne => source_identifier).group_by(&:provider).each do |key, group|
      self.send((key.to_s + '_send').to_sym, group.map(&:registration_id), options)
    end
  end

  private

  def gcm_send(devices_to_notify, options)
    @gcm ||= GCM.new(WebOmni::Application::GOOGLE_API_KEY)
    @gcm.send_notification(devices_to_notify, options) if devices_to_notify.any?
  end

  def omni_send(devices_to_notify, options)
    @omni_notification_service ||= OmniNotificationService.new()
    @omni_notification_service.send_notification(devices_to_notify, options) if devices_to_notify.any?
  end
end
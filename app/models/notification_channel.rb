require 'securerandom'

class NotificationChannel
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :calendar

  field :uuid, type: String, default: SecureRandom.uuid
  field :type, type: String, default: 'web_hook'
  field :address, type: String

  def to_params
    {
      'calendarId' => calendar.google_id,
      'id' => uuid,
      'type' => type,
      'address' => 'https://www.omnipasteapp.com/calendars/notifications'#@address
    }
  end
end
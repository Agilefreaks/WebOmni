class Calendar
  include Mongoid::Document
  include Mongoid::Timestamps

  scope :watched, -> { where(watched: true) }
  scope :not_watched, -> { where(watched: false) }

  belongs_to :user
  has_one :notification_channel, autosave: true

  field :google_id, type: String
  field :summary, type: String
  field :watched, type: Boolean, default: false

  def renew_notification_channel(callback_url)
    notification_channel.destroy unless notification_channel.nil?

    NotificationChannel.create(address: callback_url, calendar: self)
  end
end

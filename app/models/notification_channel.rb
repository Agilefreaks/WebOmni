require 'securerandom'

class NotificationChannel
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :calendar

  field :uuid, type: String, default: SecureRandom.uuid
  field :type, type: String, default: 'web_hook'
  field :address, type: String

  def initialize(address)
    @address = address
  end

  def to_params
    {
      id: uuid,
      type: type,
      address: address
    }
  end
end
class Clipping
  include Mongoid::Document
  include Mongoid::Timestamps

  TYPES = {
      :phone_number => :phone_number,
      :unknown => :unknown
  }

  field :token, type: String
  field :content, type: String
  field :type, type: Symbol

  validates_presence_of :token, :content

  index token: 1

  scope :for_channel, ->(channel) { where(token: channel).desc(:created_at) }
end
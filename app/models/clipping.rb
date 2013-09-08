class Clipping
  include Mongoid::Document
  include Mongoid::Timestamps

  field :token, :type => String
  field :content, :type => String

  validates_presence_of :token, :content

  index token: 1

  scope :for_channel, ->(channel) { where(token: channel).desc(:created_at) }
end
class Clipping
  include Mongoid::Document
  include Mongoid::Timestamps

  field :token, :type => String
  field :content, :type => String

  validates_presence_of :token, :content
end
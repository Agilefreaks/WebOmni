class Clipping
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :token, :content

  field :token, :type => String
  field :content, :type => String
end
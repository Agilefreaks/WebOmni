class Clipping
  include Mongoid::Document
  include Mongoid::Timestamps

  field :token, :type => String
  field :content, :type => String
end
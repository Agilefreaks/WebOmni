class RegisteredDevice
  include Mongoid::Document
  include Mongoid::Timestamps

  field :registration_id, type: String
  field :name, type: String
  field :identifier, type: String

  embedded_in :user

  validates_presence_of :identifier
end

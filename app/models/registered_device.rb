class RegisteredDevice
  include Mongoid::Document
  include Mongoid::Timestamps

  field :registration_id, type: String

  embedded_in :user

  validates_presence_of :registration_id
end

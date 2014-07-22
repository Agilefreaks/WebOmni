class Wizard
  include Mongoid::Document
  include Mongoid::Timestamps

  field :devices, type: Array

  embedded_in :user
end

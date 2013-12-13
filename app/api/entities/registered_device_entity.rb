module Entities
  class RegisteredDeviceEntity < Grape::Entity
    expose :identifier, :name, :registration_id, :updated_at, :created_at
  end
end
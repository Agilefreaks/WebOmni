module Entities
  class ClippingEntity < Grape::Entity
    expose :id, :token, :content, :created_at
  end
end
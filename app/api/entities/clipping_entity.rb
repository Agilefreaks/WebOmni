module Entities
  class ClippingEntity < Grape::Entity
    expose :id, :token, :content, :type, :created_at
  end
end
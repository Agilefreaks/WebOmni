module Entities
  class ClippingEntity < Grape::Entity
    expose :id, :token, :content, :content_type, :created_at
  end
end
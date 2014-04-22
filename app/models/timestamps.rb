module Timestamps
  extend ActiveSupport::Concern

  included do
    schema do
      string :updated_at
      string :created_at
    end
  end
end
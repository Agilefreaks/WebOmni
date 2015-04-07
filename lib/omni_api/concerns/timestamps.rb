module OmniApi
  module Concerns
    module Timestamps
      extend ActiveSupport::Concern

      included do
        attr_accessible :updated_at, :created_at
      end
    end
  end
end

module Analyzable
  extend ActiveSupport::Concern

  included do
    field :mixpanel_distinct_id, type: String
    field :remote_ip, type: String
    field :aliased, type: Boolean, default: false
  end
end

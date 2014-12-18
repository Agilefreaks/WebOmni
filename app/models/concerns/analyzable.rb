module Analyzable
  extend ActiveSupport::Concern

  included do
    field :mixpanel_distinct_id
    field :remote_ip
  end
end
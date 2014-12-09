module Analyzable
  extend ActiveSupport::Concern

  included do
    field :mixpanel_distinct_id
    field :email
    field :remote_ip

    after_create :track_user_registration
  end

  def track_user_registration
    return if mixpanel_distinct_id.to_s.empty?

    user_params = {
        first_name: first_name,
        last_name: last_name,
        email: email,
        remote_ip: remote_ip
    }
    Track.alias(mixpanel_distinct_id, email, user_params)
  end
end
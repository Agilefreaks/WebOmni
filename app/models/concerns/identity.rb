module Identity
  extend ActiveSupport::Concern

  included do
    field :expires, default: true
    field :expires_at, type: DateTime
    field :token, type: String, default: ''
    field :refresh_token, type: String, default: ''

    def expired?
      expires == true && expires_at < DateTime.now
    end

    def has_calendar_access?
      token != blank? && !expired?
    end
  end
end
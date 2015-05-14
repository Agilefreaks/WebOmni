module CalendarIdentity
  extend ActiveSupport::Concern

  included do
    field :expires, default: true
    field :expires_at, type: DateTime, default: DateTime.now
    field :token, type: String, default: ''
    field :refresh_token, type: String, default: ''
    field :scope, type: String, default: ''

    def expired?
      expires == true && expires_at < DateTime.now
    end

    def has_access?
      token != blank? && !expired?
    end
  end
end
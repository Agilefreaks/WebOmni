class Identity
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :provider, type: String, default: ''
  field :scope, type: String, default: ''
  field :expires, type: Boolean, default: true
  field :expires_at, type: DateTime, default: DateTime.now
  field :token, type: String, default: ''
  field :refresh_token, type: String, default: ''

  def expired?
    expires == true && expires_at < DateTime.now
  end

  def has_valid_token?
    token != blank? && !expired?
  end

  def has_calendar_access?
    has_valid_token? && (scope.include? 'calendar.readonly')
  end
end
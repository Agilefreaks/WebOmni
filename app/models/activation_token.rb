class ActivationToken
  include Mongoid::Document
  include Mongoid::Timestamps

  TYPES = {
    'unknown' => :unknown,
    'windows' => :windows,
    'android' => :android
  }

  field :content, type: String, default: SecureRandom.uuid
  field :type, type: Symbol, default: TYPES['unknown']
  field :used, type: Boolean, default: false

  embedded_in :user

  index created_at: -1
end
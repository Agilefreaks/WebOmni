class ActivationToken
  include Mongoid::Document
  include Mongoid::Timestamps

  scope :unused, where(:used => false)

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

  def self.first_unused(content)
    unused.where(content: content).first
  end
end
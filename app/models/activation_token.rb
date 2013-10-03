class ActivationToken
  include Mongoid::Document
  include Mongoid::Timestamps

  TYPES = { :none => :none, :windows => :windows, :android => :android }

  scope :active, where(:active? => true)


  field :content, type: String, default: SecureRandom.uuid
  field :type, type: Symbol, default: TYPES[:none]
  field :active?, type: Boolean, default: true
  embeds_one :user

  index created_at: -1
end
class User
  include Mongoid::Document
  include Mongoid::Timestamps

  include Concerns::UserDevise

  # fields
  field :first_name, :type => String
  field :last_name, :type => String
  field :nickname, :type => String
  field :early_adopter, :type => Mongoid::Boolean, :default => -> { User.where(early_adopter: true).count < WebOmni::Application::USER_LIMIT }
  field :image_url, :type => String
  field :devices, :type => Array

  # relations
  embeds_many :providers
  accepts_nested_attributes_for :providers

  embeds_many :activation_tokens
  accepts_nested_attributes_for :activation_tokens

  embeds_many :registered_devices
  accepts_nested_attributes_for :registered_devices
  
  embeds_many :clippings

  def name
    "#{first_name} #{last_name}"
  end

  def active_registered_devices
    registered_devices.active
  end

  def find_provider(uid, name)
    providers.where(:uid => uid, :name => name).first
  end

  def self.find_by_provider(email, provider)
    User.find_by('providers.email' => email, 'providers.name' => provider)
  end
end

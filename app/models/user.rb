class User < ActiveResource::Base
  include Timestamps
  include Concerns::UserDevise

  schema do
    string :email
    string :first_name
    string :last_name
    string :nickname
    string :image_url
  end

  attr_accessor :first_name

  # # fields
  # field :devices, :type => Array

  has_many :providers

  def name
    "#{first_name} #{last_name}"
  end

  def active_registered_devices
    registered_devices.active
  end

  def find_provider(uid, name)
    providers.select { |provider| provider.uid == uid && provider.name == name }.first
  end

  def self.find_by_provider_or_email(email, provider)
    User.where(email: email, provider_name: provider).first
  end

  # needed for devise
  def [](attribute)
    send(attribute)
  end
end

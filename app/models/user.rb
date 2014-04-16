class User < ActiveResource::Base
  # include Concerns::UserDevise

  schema do
    string :first_name
    string :last_name
    string :nickname
    string :image_url
  end

  # # fields
  # field :devices, :type => Array

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

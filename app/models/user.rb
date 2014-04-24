class User < ApiModel
  include Concerns::Timestamps
  include Concerns::UserDevise

  headers['Authorization'] = Configuration.client_access_token

  attr_accesible :id, :first_name, :last_name, :nickname, :image_url

  has_many :providers

  def name
    "#{first_name} #{last_name}"
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

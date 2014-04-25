class User < ClientApiModel
  include Concerns::Timestamps
  include Concerns::UserDevise

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

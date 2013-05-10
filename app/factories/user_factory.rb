class UserFactory
  include Singleton

  def self.from_social(auth, user)
    factory = UserFactory.instance

    user ||= factory.create_from_social(auth)
    factory.create_or_update_provider(auth, user)

    user
  end

  def create_from_social(auth)
    match = auth.to_s.match(/image=\"(.*?)\"/)
    User.create(:first_name => auth.info.first_name,
                :last_name => auth.info.last_name,
                :email => auth.info.email,
                :password => Devise.friendly_token[0, 20],
                :image_url => match ? match[1] : nil)
  end

  def create_or_update_provider(auth, user)
    social = user.find_provider(auth.uid, auth.provider)

    if social
      social.update_attributes(:name => auth.provider, :uid => auth.uid, :auth => auth)
    else
      user.providers.create(:name => auth.provider, :uid => auth.uid, :auth => auth, :email => auth.info.email)
    end
  end
end
class UserFactory
  include Singleton

  def self.from_social(auth, user)
    factory = UserFactory.instance
    factory.create_from_social(auth)
  end

  def create_from_social(auth)
    match = auth.to_s.match(/image=\"(.*?)\"/)
    user = User.new(:first_name => auth.info.first_name,
                       :last_name => auth.info.last_name,
                       :email => auth.info.email,
                       :password => Devise.friendly_token[0, 20],
                       :image_url => match ? match[1] : nil)
    user.providers = []
    user.providers.push(Provider.new(:name => auth.provider, :uid => auth.uid, :auth => auth, :email => auth.info.email))
    user.save

    NotificationsMailer.welcome(user.id).deliver

    user
  end
end
class UserFactory
  include Singleton

  def self.from_social(auth, user)
    factory = UserFactory.instance
    factory.create_from_social(auth)
  end

  def create_from_social(auth)
    match = auth.to_s.match(/image=\"(.*?)\"/)

    api_user = OmniApi::User.where(email: auth.info.email).first ||
        OmniApi::User.new(:first_name => auth.info.first_name,
                          :last_name => auth.info.last_name,
                          :email => auth.info.email)
    api_user.save

    user = User.create(first_name: auth.info.first_name,
                       last_name: auth.info.last_name,
                       email: auth.info.email,
                       password: Devise.friendly_token[0, 20],
                       image_url: match ? match[1] : nil,
                       access_token: api_user.access_token)

    NotificationsMailer.welcome(user.id).deliver

    user
  end
end
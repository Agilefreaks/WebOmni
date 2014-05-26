class UserFactory
  include Singleton

  def self.from_social(auth, user)
    factory = UserFactory.instance
    factory.create_or_update_from_social(auth, user)
  end

  def create_or_update_from_social(auth, user)
    match = auth.to_s.match(/image=\"(.*?)\"/)

    api_user = OmniApi::User.where(email: auth.info.email).first ||
        OmniApi::User.new(:first_name => auth.info.first_name,
                          :last_name => auth.info.last_name,
                          :email => auth.info.email)
    api_user.save

    params = {
        first_name: auth.info.first_name,
        last_name: auth.info.last_name,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20],
        image_url: match ? match[1] : nil,
        access_token: api_user.access_token
    }

    if user
      user.update(params)
    else
      user = User.create(params)
      NotificationsMailer.welcome(user.id).deliver
    end

    user
  end
end
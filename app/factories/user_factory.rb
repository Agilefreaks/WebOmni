class UserFactory
  include Singleton

  def self.from_social(auth, user)
    factory = UserFactory.instance
    factory.create_or_update_from_social(auth, user)
  end

  def create_or_update_from_social(auth, user)
    Track.sign_up(auth.info.email)

    params = {
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      email: auth.info.email,
      password: Devise.friendly_token[0, 20],
      image_url: get_image_url(auth),
      access_token: api_user.access_token,
      mixpanel_distinct_id: auth.distinct_id,
      remote_ip: auth.remote_ip
    }

    if user
      user.update(params)
    else
      user = User.create(params)
      Track.alias(params[:email], auth.distinct_id, params)
    end

    api_user = OmniApi::User.where(email: user.email).first ||
      OmniApi::User.new(first_name: user.first_name,
                        last_name: user.last_name,
                        email: user.email,
                        image_url: user.image_url)
    api_user.save

    user
  end

  def get_image_url(auth)
    match = auth.to_s.match(/image="(.*?)"/)
    match ? match[1] : nil
  end
end
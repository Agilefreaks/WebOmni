class UserFactory
  include Singleton

  def self.from_social(auth, user)
    UserFactory.instance.create_or_update_from_social(auth, user)
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def create_or_update_from_social(auth, user)
    params = sanitize_params(auth)

    if user
      user.update(params)
    else
      user = User.create(params)
      Track.user_created(params[:email], params)
    end

    user
  end

  def sanitize_params(auth)
    {
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      email: auth.info.email,
      password: Devise.friendly_token[0, 20],
      image_url: auth.info.image,
      mixpanel_distinct_id: auth.distinct_id,
      remote_ip: auth.remote_ip
    }
  end
end

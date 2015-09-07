class UserFactory
  include Singleton

  def self.from_social(auth, user, api_user)
    UserFactory.instance.create_or_update_from_social(auth, user, api_user)
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def create_or_update_from_social(auth, user, api_user)
    params = sanitize_params(auth, api_user)

    if user
      user.update(params)
    else
      user = User.new(params)
      user.save

      Track.user_created(params[:email], params)
    end

    user.identity.update(identity_params(auth))

    user
  end


  def sanitize_params(auth, api_user)
    {
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      email: auth.info.email,
      password: Devise.friendly_token[0, 20],
      image_url: auth.info.image,
      mixpanel_distinct_id: auth.distinct_id,
      remote_ip: auth.remote_ip,
      access_token: api_user.access_token,
      refresh_token: api_user.refresh_token
    }
  end

  def identity_params(auth)
    {
      provider: auth.provider,
      scope: auth.scope,
      expires: auth.credentials.expires,
      expires_at: auth.credentials.expires_at,
      refresh_token: auth.credentials.refresh_token,
      token: auth.credentials.token
    }
  end
end

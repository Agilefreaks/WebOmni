class UserFactory
  include Singleton

  def self.from_social(auth)
    UserFactory.instance.create_or_update_from_social(auth)
  end

  def create_or_update_from_social(auth)
    params = sanitize_params(auth)
    user = User.find_or_initialize_by(email: auth.info.email.downcase)
    Track.user_created(params[:email], params) if user.new_record?

    user.update(params)
    UpdateUserIdentity.perform(user, auth)

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

class HandleAuthentication
  def self.for(user)
    HandleAuthentication.new(user)
  end

  def initialize(user)
    @user = user
  end

  def with(auth_info)
    @user = @user || User.where(email: auth_info.info.email.downcase).first

    api_user = OmniApi::UserFactory.from_social(auth_info)
    OmniApi::IdentityFactory.for(api_user.id).create_from(auth_info)
    UserFactory.from_social(auth_info, @user)
  end
end

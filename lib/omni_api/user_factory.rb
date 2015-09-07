module OmniApi
  class UserFactory
    include Singleton

    def self.ensure_user_exists(auth)
      OmniApi::UserFactory.instance.ensure_user_exists(auth)
    end

    def ensure_user_exists(auth)
      api_user = OmniApi::User.where(email: auth.info.email).first
      api_user || OmniApi::User.create(first_name: auth.info.first_name,
                                       last_name: auth.info.last_name,
                                       email: auth.info.email.downcase,
                                       image_url: auth.info.image)
    end
  end
end

module OmniApi
  class UserFactory
    include Singleton

    def self.from_social(auth)
      OmniApi::UserFactory.instance.create_or_update_api_user(auth)
    end

    def create_or_update_api_user(auth)
      api_user = OmniApi::User.where(email: auth.info.email).first
      api_user = api_user || OmniApi::User.create(first_name: auth.info.first_name,
                                   last_name: auth.info.last_name,
                                   email: auth.info.email.downcase,
                                   image_url: auth.info.image)

      api_user
    end
  end
end

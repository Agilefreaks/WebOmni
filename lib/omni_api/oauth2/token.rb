module OmniApi
  module Oauth2
    class Token < OmniApi::BaseClientModel
      attr_accessible :access_token, :refresh_token, :token_type, :expires_in

      self.site = "#{OmniApi.config.base_url}/oauth2"

      def self.create_for(user_email)
        instance = self.new
        instance.attributes[:grant_type] = OmniApi::Oauth2::GrantTypes::CLIENT_CREDENTIALS
        instance.attributes[:client_id] = OmniApi.config.client_id
        instance.attributes[:client_secret] = OmniApi.config.client_secret
        instance.attributes[:user_email] = user_email
        instance.save
        instance
      end

      def self.refresh(refresh_token)
        instance = self.new
        instance.attributes[:grant_type] = OmniApi::Oauth2::GrantTypes::REFRESH_TOKEN
        instance.attributes[:refresh_token] = refresh_token
        instance.save
        instance
      end

      def self.collection_name
        'token'
      end
    end
  end
end
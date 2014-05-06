module OmniApi
  module Phones
    class Call
      include HTTParty

      base_uri Rails.application.config.active_resource.site

      attr_accessor :authorization

      def self.for(user)
        Call.new(user.access_token)
      end

      def with(phone_number)
        post_body = { phone_number: phone_number }

        params = {
            body: post_body.to_json,
            headers: {
                'Authorization' => "bearer #{@authorization}",
                'Content-Type' => 'application/json'
            }
        }

        self.class.post('/phones/call', params)
      end

      private

      def initialize(authorization)
        @authorization = authorization
      end
    end
  end
end

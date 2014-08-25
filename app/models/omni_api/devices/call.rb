module OmniApi
  module Devices
    class Call
      include HTTParty

      base_uri OmniApi.config.base_url

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

        self.class.post('/devices/call', params)
      end

      private

      def initialize(authorization)
        @authorization = authorization
      end
    end
  end
end

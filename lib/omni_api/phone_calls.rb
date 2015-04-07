module OmniApi
  class PhoneCalls
    include HTTParty

    base_uri OmniApi.config.base_url

    attr_accessor :authorization

    def create(access_token, number)
      post_body = {
        number: number,
        type: 'outgoing',
        state: 'starting'
      }

      self.class.post('/phone_calls', params(post_body, access_token))
    end

    private

    def params(body, access_token)
      {
        body: body.to_json,
        headers: {
          'Authorization' => "bearer #{access_token}",
          'Content-Type' => 'application/json'
        }
      }
    end
  end
end

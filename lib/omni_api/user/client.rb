module OmniApi
  class User
    class Client < UserResource
      include OmniApi::Concerns::Timestamps

      attr_accessible :id, :client_url, :client_name, :token, :client_id
    end
  end
end
module OmniApi
  class BaseClientModel < BaseModel
    headers['Authorization'] = Configuration.client_access_token
  end
end

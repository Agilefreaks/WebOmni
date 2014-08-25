module OmniApi
  class BaseClientModel < BaseModel
    self.site = OmniApi.config.base_url

    headers['Authorization'] = OmniApi.config.client_access_token
  end
end

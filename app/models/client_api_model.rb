class ClientApiModel < ApiModel
  headers['Authorization'] = Configuration.client_access_token
end
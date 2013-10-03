module WebOmni
  class Resources::ActivationTokensAPI < Grape::API
    resources :activation_tokens do
      put '/' do
        activation_token = ActivationToken.active.find_by(content: headers['Token'])
        activation_token.is_active = false
        activation_token.save!
      end
    end
  end
end
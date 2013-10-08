module WebOmni
  class Resources::ActivationTokensAPI < Grape::API
    resources :activation_tokens do
      put '/' do
        user = User.where('activation_tokens.content' => headers['Token']).first

        ActivationContext.activate(user, headers['Token'], headers['Device'])
      end
    end
  end
end

module WebOmni
  class Resources::ActivationTokensAPI < Grape::API
    resources :activation_tokens do
      put '/' do
        user = User.elem_match(activation_tokens: {content: headers['Token']}).first

        ActivationContext.call(user, headers['Token'], headers['Device'])
      end
    end
  end
end

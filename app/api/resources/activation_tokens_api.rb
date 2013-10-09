module WebOmni
  class Resources::ActivationTokensAPI < Grape::API
    resources :activation_tokens do
      put '/' do
        user = User.elem_match(activation_tokens: {content: headers['Token']}).first
        activated = ActivationContext.activate(user, headers['Token'], headers['Device'])
        present user, :with => Entities::UserActivateResponseEntity if activated
      end
    end
  end
end

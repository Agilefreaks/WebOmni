module WebOmni
  class Resources::ActivationTokensAPI < Grape::API
    resources :activation_tokens do
      put '/' do
        user = User.where('activation_tokens.content' => headers['Token']).first
        activated = ActivationService.new.activate(user.id, headers['Token'], headers['Device'])
        present user, :with => Entities::UserActivateResponseEntity if activated
      end
    end
  end
end

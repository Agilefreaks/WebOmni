module WebOmni
  class Resources::ActivationTokensAPI < Grape::API
    resources :activation_tokens do
      desc 'activate a new device using an activation token'
      params do
        requires :token, type: String, desc: 'secret activation_token. You can get this from the /whatsmytoken page'
        requires :device, type: String, desc: 'this is the device type. Possible devices are windows or android'
      end
      put '/' do
        user = User.where('activation_tokens.content' => params[:token]).first
        activated = ActivationService.new.activate(user.id, params[:token], params[:device])

        present user, :with => Entities::UserActivateResponseEntity if activated
      end
    end
  end
end

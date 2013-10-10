module WebOmni
  class Resources::ActivationTokensAPI < Grape::API
    resources :activation_tokens do
      desc 'activate a new device using an activation token'
      params do
        requires :token, type: String, desc: 'secret activation_token. You can get this from the /whatsmytoken page'
        requires :device, type: String, desc: 'this is the device type. Possible devices are windows or android'
      end
      put '/' do
        activation_token = ActivationService.new.activate(params[:token], params[:device])

        present activation_token.user, :with => Entities::UserActivateResponseEntity if activation_token
      end
    end
  end
end

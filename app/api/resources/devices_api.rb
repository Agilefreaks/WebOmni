module WebOmni
  class Resources::DevicesAPI < Grape::API
    resources :devices do
      helpers do
        def permitted_params
          ActionController::Parameters.new(params).permit(:registrationId)
        end

        def call_permitted_params
          ActionController::Parameters.new(params).permit(:registrationId, :phone_number)
        end

        def channel
          channel = headers['Channel']
          error!('Unauthorized', 401) if channel.nil?
          channel
        end
      end

      desc 'Register a device'
      params do
        requires :registrationId, type: String, desc: 'The unique identifier for your device.'
      end
      post '/' do
        Register.device(channel, permitted_params[:registrationId])
      end

      params do
        requires :registrationId, type: String, desc: 'The unique identifier for your device.'
      end
      delete '/' do
        Unregister.device(channel, permitted_params[:registrationId])
      end

      desc 'Call the number'
      params do
        requires :phone_number, type: String
      end
      post '/call' do
        Call.device(channel, call_permitted_params[:registrationId], call_permitted_params[:phone_number])
      end

      desc 'Activate a new device using an activation token.', {
          :headers => {
              :'Token' => {
                  desc: 'Secret activation_token. You can get this from the /whatsmytoken page after logging in.',
                  require: true
              }
          }
      }
      params do
        requires :device, type: Symbol, values: [], desc: 'Device type. Possible devices are windows or android'
      end
      put '/activate' do
        activation_token = ActivationService.new.activate(params[:token], params[:device])

        present activation_token.user, :with => Entities::UserActivateResponseEntity if activation_token
      end
    end
  end
end
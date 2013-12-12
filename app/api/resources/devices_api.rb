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
          headers['Channel']
        end
      end

      desc 'Register a device', {
          headers: {
              :'Channel' => {
                  description: 'The channel this clipping should be propagated to, usually the users email address',
                  required: true
              }
          }
      }
      params do
        requires :registrationId, type: String, desc: 'The unique identifier for your device.'
      end
      post '/' do
        authenticate!
        Register.device(channel, permitted_params[:registrationId])
      end

      desc 'Unregister a device.', {
          headers: {
              :'Channel' => {
                  description: 'The channel this clipping should be propagated to, usually the users email address',
                  required: true
              }
          }
      }
      params do
        requires :registrationId, type: String, desc: 'The unique identifier for your device.'
      end
      delete '/' do
        authenticate!
        Unregister.device(channel, permitted_params[:registrationId])
      end

      desc 'Call the number'
      params do
        requires :phone_number, type: String
      end
      post '/call' do
        Call.device(channel, call_permitted_params[:registrationId], call_permitted_params[:phone_number])
      end
    end
  end
end
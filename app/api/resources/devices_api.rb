module WebOmni
  class Resources::DevicesAPI < Grape::API
    resources :devices do
      helpers do
        def register_params
          result = params.merge(channel: headers['Channel'])
          ActionController::Parameters.new(result).permit(:channel, :identifier, :name)
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
        requires :identifier, type: String, desc: 'Unique device identifier.'
        optional :name, type: String, desc: 'The name of the device.'
      end
      post '/' do
        authenticate!
        Register.device(register_params)
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

      desc 'Activate a device.', {
          headers: {
              :'Channel' => {
                  description: 'The channel this clipping should be propagated to, usually the users email address',
                  required: true
              }
          }
      }

      desc 'Call the number', {
          headers: {
              :'Channel' => {
                  description: 'The channel this clipping should be propagated to, usually the users email address',
                  required: true
              }
          }
      }
      params do
        requires :phone_number, type: String
      end
      post '/call' do
        Call.device(channel, call_permitted_params[:registrationId], call_permitted_params[:phone_number])
      end
    end
  end
end
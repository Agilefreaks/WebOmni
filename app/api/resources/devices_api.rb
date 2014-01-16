module WebOmni
  class Resources::DevicesAPI < Grape::API
    resources :devices do
      helpers do
        def register_params
          ActionController::Parameters.new(merged_params).permit(:channel, :identifier, :name)
        end

        def unregister_params
          ActionController::Parameters.new(merged_params).permit(:channel, :identifier)
        end

        def activate_params
          ActionController::Parameters.new(merged_params).permit(:channel, :identifier, :registration_id)
        end

        def deactivate_params
          ActionController::Parameters.new(merged_params).permit(:channel, :identifier)
        end

        def merged_params
          params.merge(channel: headers['Channel'])
        end
      end

      desc 'Register a device', {
          headers: {
              :'Channel' => {
                  description: 'The channel, usually the users email address',
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
        present Register.device(register_params), with: Entities::RegisteredDeviceEntity
      end

      desc 'Unregister a device.', {
          headers: {
              :'Channel' => {
                  description: 'The channel, usually the users email address',
                  required: true
              }
          }
      }
      params do
        requires :identifier, type: String, desc: 'Unique device identifier.'
      end
      route_param :identifier do
        delete '/' do
          authenticate!
          Unregister.device(unregister_params)
        end
      end

      desc 'Activate.', {
          headers: {
              :'Channel' => {
                  description: 'The channel, usually the users email address',
                  required: true
              }
          }
      }
      params do
        requires :registration_id, type: String, desc: 'The registration id for the push notification service.'
        requires :identifier, type: String, desc: 'The unique device identifier.'
        optional :provider, type: Symbol, values: [:gcm], desc: 'The push notification provider'
      end
      put 'activate' do
        authenticate!
        present ActivateDevice.with(activate_params), with: Entities::RegisteredDeviceEntity
      end

      desc 'Deactivate.', {
          headers: {
              :'Channel' => {
                  description: 'The channel, usually the users email address',
                  required: true
              }
          }
      }
      params do
        requires :identifier, type: String, desc: 'The unique device identifier.'
      end
      put 'deactivate' do
        authenticate!
        present DeactivateDevice.with(deactivate_params), with: Entities::RegisteredDeviceEntity
      end
    end
  end
end
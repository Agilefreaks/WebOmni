module WebOmni
  class Resources::DevicesAPI < Grape::API
    resources :devices do
      helpers do
        def permitted_params
          ActionController::Parameters.new(params).permit(:registrationId)
        end

        def channel
          channel = headers['Channel']
          error!('Unauthorized', 401) if channel.nil?
          channel
        end
      end

      desc 'Register a device'
      params do
        requires :registrationId, type: String
      end
      post '/' do
        Register.device(channel, permitted_params[:registrationId])
      end

      desc 'Unregister a device'
      params do
        requires :registrationId, type: String
      end
      delete ':registrationId' do
        Unregister.device(channel, permitted_params[:registrationId])
      end
    end
  end
end
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
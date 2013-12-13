module WebOmni
  class Resources::PhonesAPI < Grape::API
    resources :phones do
      helpers do
        def call_params
          ActionController::Parameters.new(merged_params).permit(:channel, :phone_number)
        end

        def merged_params
          params.merge(channel: headers['Channel'])
        end
      end

      desc 'Call the number.', {
          headers: {
              :'Channel' => {
                  description: 'The channel, usually the users email address',
                  required: true
              }
          }
      }
      params do
        requires :phone_number, type: String, desc: 'The phone number to dial.'
      end
      post '/call' do
        authenticate!
        Call.with(call_params)
      end
    end
  end
end
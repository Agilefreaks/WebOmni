module WebOmni
  class Resources::ClippingsAPI < Grape::API
    resources :clippings do
      helpers do
        def permitted_params
          ActionController::Parameters.new(params).permit(:content, :token, :registrationId)
        end
      end

      desc 'Create a clipping', {
          headers: {
              :'Channel' => {
                  description: 'The channel this clipping should be propagated to, usually the users email address',
                  required: true
              },
              :'Source-Device' => {
                  description: 'Source device registration id, generated on POST device',
                  required: true
              }
          }
      }
      params do
        requires :content, type: String, desc: 'Content for the clipping'
      end
      post '/' do
        present ClippingFactory.create(permitted_params), :with => Entities::ClippingEntity
      end

      desc 'Get latest clipping for a given Channel and Device', {
          headers: {
              :'Channel' => {
                  description: 'The channel this clipping should be propagated to, usually the users email address',
                  required: true
              },
              :'Destination-Device' => {
                  description: 'Destination device registration id, generated on POST device',
                  required: true
              }
          }
      }
      get '/' do
        channel = headers['Channel']
        error!('Unauthorized', 401) if channel.nil?

        latest = Clipping.for_channel(channel).first
        present latest, :with => Entities::ClippingEntity
      end
    end
  end
end
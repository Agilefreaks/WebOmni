module WebOmni
  class Resources::ClippingsAPI < Grape::API
    resources :clippings do
      helpers do
        def post_params
          result = params.merge(channel: headers['Channel'])
          ActionController::Parameters.new(result).permit(:content, :channel)
        end
      end

      desc 'Create a clipping.', {
          headers: {
              :'Channel' => {
                  description: 'The channel this clipping should be propagated to, usually the users email address',
                  required: true
              }
          }
      }
      params do
        requires :content, type: String, desc: 'Content for the clipping'
      end
      post '/' do
        authenticate!
        present CreateClipping.with(post_params), with: Entities::ClippingEntity
      end

      desc 'Get latest clipping.', {
          headers: {
              :'Channel' => {
                  description: 'The channel this clipping should be propagated to, usually the users email address',
                  required: true
              }
          }
      }
      get '/' do
        authenticate!
        present FindClipping.for(current_user.email), :with => Entities::ClippingEntity
      end
    end
  end
end
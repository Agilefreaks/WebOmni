module WebOmni
  class Resources::ClippingsAPI < Grape::API
    resources :clippings do
      helpers do
        def permitted_params
          ActionController::Parameters.new(params).permit(:content, :token)
        end
      end

      desc 'Create a clipping'
      params do
        requires :token, type: String
        requires :content, type: String
      end
      post '/' do
        present ClippingFactory.create(permitted_params), :with => Entities::ClippingEntity
      end

      desc 'Get latest clipping for a given :token'
      get '/' do
        channel = headers['Channel']
        error!('Unauthorized', 401) if channel.nil?

        latest = Clipping.for_channel(channel).first
        present latest, :with => Entities::ClippingEntity
      end
    end
  end
end
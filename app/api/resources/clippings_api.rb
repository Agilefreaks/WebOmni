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
        new_clipping = Clipping.new(permitted_params)
        new_clipping.save!

        status 201
        present new_clipping, :with => Entities::ClippingEntity
      end

      desc 'Get latest clipping for a given :token'
      get '/' do
        channel = headers['Channel']
        error!('Unauthorized', 401) if channel.nil?
        last_clipping = Clipping.where(:token => channel).desc(:created_at).first

        present last_clipping, :with => Entities::ClippingEntity
      end
    end
  end
end
module WebOmni
  class Resources::ClippingsAPI < Grape::API
    resources :clippings do
      desc 'Create a clipping'
      params do
        requires :token, type: String
        requires :content, type: String
      end
      post '/' do
        new_clipping = Clipping.new({ :content => params[:content], :token => params[:token] })
        new_clipping.save!

        status 201
        new_clipping
      end

      desc 'Get a clipping'
      params do
        requires :id, type: String, desc: 'Clipping id.'
      end
      get '/:id' do
        Clipping.find(params[:id])
      end

      desc 'Get latest clipping for a given :token'
      get '/' do
        channel = headers['Channel']
        error!('Unauthorized', 401) if channel.nil?
        Clipping
        .find_by(token: channel)
        .sort_by { |c| c.created_at }
        .last
      end
    end
  end
end
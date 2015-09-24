class SdkController < ApplicationController
  layout false

  respond_to :js

  skip_before_action :verify_authenticity_token

  def show
    response.headers['Content-type'] = 'text/javascript; charset=utf-8'
    respond_with @api_client = OmniApi::Resources::Client.find(params[:id])
  rescue ActiveResource::ResourceNotFound => _
    head 404
  end
end

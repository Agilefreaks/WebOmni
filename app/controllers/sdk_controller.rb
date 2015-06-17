class SdkController < ApplicationController
  layout false

  respond_to :js

  skip_before_action :verify_authenticity_token

  def show
    response.headers['Content-type'] = 'text/javascript; charset=utf-8'
    respond_with @api_key = params[:id]
  end
end

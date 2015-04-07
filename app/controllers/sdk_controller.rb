class SdkController < ApplicationController
  layout false
  respond_to :js

  before_action :js_content_type
  skip_before_action :verify_authenticity_token

  def js_content_type
    response.headers['Content-type'] = 'text/javascript; charset=utf-8'
  end

  def show
    respond_with @api_key = params[:id]
  end
end

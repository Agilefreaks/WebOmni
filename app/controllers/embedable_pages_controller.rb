class EmbedablePagesController < ApplicationController
  layout 'embedable'

  before_action :get_client!
  before_action :authenticate!

  def user_access_token
    @user_access_token = current_user.access_token
    render :user_access_token
  end

  private

  def get_client!
    @api_client = OmniApi::Client.where(id: params[:api_client_id]).first
    head 401 unless @api_client
  end
end

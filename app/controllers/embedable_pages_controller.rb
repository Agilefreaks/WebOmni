class EmbedablePagesController < ApplicationController
  layout 'embedable'

  before_action :authenticate!
  before_action :get_client!

  def prepare_for_phone_usage
  end

  private

  def get_client!
    begin
      @client = OmniApi::User::Client.find(params[:api_client_id])
    rescue ActiveResource::ResourceNotFound
      session[:callback_url] = prepare_for_phone_usage_path(params[:api_client_id])
      redirect_to new_users_client_path(api_client_id: params[:api_client_id])
    end
  end
end

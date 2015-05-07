class EmbedablePagesController < ApplicationController
  layout 'embedable'

  before_action :authenticate!
  before_action :get_client!

  def user_access_token
  end

  private

  def get_client!
    begin
      @client = OmniApi::User::Client.find(params[:api_client_id])
    rescue ActiveResource::ResourceNotFound
      redirect_to new_users_client_path(api_client_id: params[:api_client_id])
    end
  end
end

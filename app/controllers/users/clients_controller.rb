module Users
  class ClientsController < ApplicationController
    layout 'embedable'

    before_action :authenticate!

    def new
      @client_description = OmniApi::ClientDescription.find(params[:api_client_id])
      @client = OmniApi::User::Client.new({client_id: params[:api_client_id]})
    end

    def create
      @client = OmniApi::User::Client.new(params[:omni_api_user_client])
      begin
        @client.save
        redirect_to session[:callback_url]
      rescue => exception
        flash[:error] = exception
        redirect_to new_users_client_path({api_client_id: @client.client_id})
      end
    end
  end
end
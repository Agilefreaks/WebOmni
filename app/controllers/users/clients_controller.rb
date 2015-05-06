module Users
  class ClientsController < ApplicationController
    before_action :authenticate!

    def new
      @client_description = OmniApi::ClientDescription.find(params[:api_client_id])
      @client = OmniApi::User::Client.new({client_id: params[:api_client_id]})
    end

    def create
      @client = OmniApi::User::Client.new(params[:client])
      redirect_to @client.save ? session[:callback_url] : association_failed_path
    end
  end
end
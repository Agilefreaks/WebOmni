module Users
  class ClientsController < ApplicationController
    before_action :authenticate!

    def new
      @client_description = OmniApi::ClientDescription.find(params[:api_client_id])
      @client = OmniApi::User::Client.new({id: params[:api_client_id]})
    end
  end
end
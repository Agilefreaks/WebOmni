module JsApi
  module User
    class ClientsController < ApplicationController
      layout 'embedable'

      before_action :authenticate!

      def new
        @client_description = OmniApi::Resources::Client.find(params[:api_client_id])
        @client = OmniApi::Resources::User::ClientAssociation.new(client_id: params[:api_client_id])
      end

      def create
        @client = OmniApi::Resources::User::ClientAssociation.new(params[:omni_api_resources_user_client_association])
        begin
          @client.save
          redirect_to session[:callback_url]
        rescue => exception
          flash[:error] = exception
          redirect_to new_user_client_path(api_client_id: @client.client_id)
        end
      end
    end
  end
end

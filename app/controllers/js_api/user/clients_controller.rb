module JsApi
  module User
    class ClientsController < ApplicationController
      layout 'embedable'

      before_action :authenticate!

      def new
        @client_description = OmniApi::Client.find(params[:api_client_id])
        @client = OmniApi::User::ClientAssociation.new(client_id: params[:api_client_id])
      end

      def create
        @client = OmniApi::User::ClientAssociation.new(params[:omni_api_user_client_association])
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

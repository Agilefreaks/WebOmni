module JsApi
  class EmbedablePagesController < ApplicationController
    layout 'embedable'

    before_action :authenticate!
    before_action :find_client!

    def prepare_for_phone_usage
      context = params.slice(:api_client_id).merge(user: current_user)
      result = PhoneCalls::EnsureReadyForPhoneCallUseCase.perform(context)
      if result.success?
        @client_association = result.client_association
      else
        errors = result.errors
        session[:callback_url] = prepare_for_phone_usage_path(params[:api_client_id])
        if errors[:client_association]
          redirect_to new_user_client_path(api_client_id: params[:api_client_id])
        elsif errors[:devices]
          redirect_to new_user_device_path
        end
      end
    end

    def call_in_progress
    end

    private

    def find_client!
      @client = OmniApi::Resources::Client.find(params[:api_client_id])
    end
  end
end

class EmbedablePagesController < ApplicationController
  layout 'embedable'

  before_action :authenticate!

  def prepare_for_phone_usage
    result = PhoneCalls::EnsureReadyForPhoneCallUseCase.perform(params.slice(:api_client_id))
    if result.errors[:api_client]
      session[:callback_url] = prepare_for_phone_usage_path(params[:api_client_id])
      redirect_to new_users_client_path(api_client_id: params[:api_client_id])
    end
  end
end

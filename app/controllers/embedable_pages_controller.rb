class EmbedablePagesController < ApplicationController
  layout 'embedable'

  before_action :authenticate!

  def prepare_for_phone_usage
    context = params.slice(:api_client_id).merge({user: current_user})
    result = PhoneCalls::EnsureReadyForPhoneCallUseCase.perform(context)
    errors = result.errors
    unless errors.empty?
      session[:callback_url] = prepare_for_phone_usage_path(params[:api_client_id])
      if errors[:api_client]
        redirect_to new_users_client_path(api_client_id: params[:api_client_id])
      elsif errors[:devices]
        redirect_to new_users_device_path
      end
    end
  end
end

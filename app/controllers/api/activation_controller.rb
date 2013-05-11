class Api::ActivationController < ApplicationController
  respond_to :json

  def activate
    user = User.find_by(token: params[:token])

    result = Jbuilder.encode do |json|
      json.activation_data do
        json.channel user.email
      end
    end

    respond_with result
  end
end
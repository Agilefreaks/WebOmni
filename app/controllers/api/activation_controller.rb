class Api::ActivationController < ApplicationController

  respond_to :json

  def activate

    activation_data = {}
    result = { :activation_data => activation_data}
    if params[:token] == "testToken"
      activation_data[:channel]= "test"
    else
      activation_data[:errors] = "Token not found"
    end

    respond_with result
  end
end
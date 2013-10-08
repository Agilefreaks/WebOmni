class TokensController < ApplicationController
  before_action :check_authentication, only: [:show]

  respond_to :html

  def show
    @token = ActivationContext.get_activation_token(current_user).content
    respond_with @token
  end
end

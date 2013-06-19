class TokensController < ApplicationController
  before_action :check_authentication, only: [:show]

  respond_to :html

  def show
    @token = current_user.token
    respond_with @token
  end
end

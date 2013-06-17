class TokensController < ApplicationController
  before_filter :authenticate_user!, only: [:show]

  respond_to :html

  def show
    @token = current_user.token
    respond_with @token
  end
end

class UsersController < ApplicationController
  def update
    current_user.update_attributes!(params.require(:user).permit(:devices => []))
    redirect_to root_path, notice: 'Options saved. Thank you!'
  end
end

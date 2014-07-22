class InstallController < ApplicationController
  include Wicked::Wizard

  prepend_before_action :set_steps

  steps :login, :devices_selection

  def show
    case step
      when :login
        skip_step if user_signed_in?
      else
        # type code here
    end

    render_wizard
  end

  private

  def set_steps
    # code here
  end
end

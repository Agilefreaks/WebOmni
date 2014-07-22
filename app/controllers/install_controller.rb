class InstallController < ApplicationController
  include Wicked::Wizard

  INITIAL_STEPS = [:login, :devices_selection]
  FINAL_STEP = [:finish]
  NUMBER_OF_STEPS = 3

  prepend_before_filter :set_steps
  before_action :authenticate!, only: :update

  def show
    case step
      when :login
        skip_step if user_signed_in?
      when :devices_selection
        if steps.count > NUMBER_OF_STEPS
          skip_step
        else
          @wizard = Wizard.new
        end
      when :phone, :tablet
        NotificationsMailer.install_instructions(step, current_user.id).deliver
      when :finish
        current_user.wizard.delete if current_user.wizard
      else
        # type code here
    end

    render_wizard
  end

  def update
    wizard = current_user.wizard = Wizard.new
    wizard.devices = []
    wizard.devices << :laptop if params['laptop']
    wizard.devices << :phone if params['phone']
    wizard.devices << :tablet if params['tablet']

    current_user.save

    redirect_to install_path(:devices_selection)
 end

  private

  def set_steps
    devices = []
    devices = current_user.wizard.devices || [] if user_signed_in? && current_user.wizard
    self.steps = INITIAL_STEPS + devices + FINAL_STEP
  end
end

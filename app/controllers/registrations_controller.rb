class RegistrationsController < ApplicationController
  before_action :set_partner_cookie

  def startupchile
    @welcome = 'Hi there Startup Chile folks, glad you dropped by.'

    render template: '/pages/welcome'
  end

  def soft32
    @welcome = 'Hi there Soft32 visitor, glad you dropped by.'

    render template: '/pages/welcome'
  end

  private

  def set_partner_cookie
    cookies[:partner] = true
  end
end

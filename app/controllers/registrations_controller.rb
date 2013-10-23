class RegistrationsController < ApplicationController
  def startupchile
    @welcome = 'Hi there Startup Chile folks, glad you dropped by.'
    @state = :chile

    render template: '/pages/welcome'
  end

  def soft32
    @welcome = 'Hi there Soft32 visitor, glad you dropped by.'
    @state = :soft32

    render template: '/pages/welcome'
  end
end

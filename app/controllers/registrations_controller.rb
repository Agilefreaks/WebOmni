class RegistrationsController < ApplicationController
  def startupchile
    @welcome = 'Hi there Startup Chile folks, glad you dropped by, Omnipaste is a clipboard manager in the cloud and works like your short-term memory.'
    @state = :chile

    render template: '/pages/welcome'
  end

  def soft32
    @welcome = 'Hi there soft32 visitor, glad you dropped by, Omnipaste is a clipboard manager in the cloud and works like your short-term memory.'
    @state = :soft32

    render template: '/pages/welcome'
  end
end

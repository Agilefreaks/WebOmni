module Users
  class DevicesController < ApplicationController
    layout 'embedable'

    before_action :authenticate!

    def new
    end
  end
end
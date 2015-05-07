module Users
  class DevicesController < ApplicationController
    before_action :authenticate!

    def new
    end
  end
end
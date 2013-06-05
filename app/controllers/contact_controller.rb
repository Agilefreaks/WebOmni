class ContactController < ApplicationController
  def create
    @message = Message.new(params[:message])
    
    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      render
    end
  end
end
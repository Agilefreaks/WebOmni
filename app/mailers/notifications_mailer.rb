class NotificationsMailer < ActionMailer::Base
  default to: "calinoiu.alexandru@agilefreaks.com;nistor.adrian@agilefreaks.com"
  default from: "nistor.adrian@agilefreaks.com"

  def new_message(message)
    @message = message
    mail({
      :from => @message.email, 
      :subject => "[Omnipaste] - New message"
    })
  end
end
class NotificationsMailer < ActionMailer::Base
  default from: 'Omnipaste <team@omnipasteapp.com>'

  def new_message(message)
    @message = message
    mail({
             to: 'calinoiu.alexandru@agilefreaks.com;nistor.adrian@agilefreaks.com;ciprian.stavar@gmail.com',
             from: @message.email,
             subject: '[Omnipaste] - New message'
         })
  end

  def welcome

  end
end
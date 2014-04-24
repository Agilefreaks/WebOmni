class NotificationsMailer < ActionMailer::Base
  default from: 'Omnipaste <team@omnipasteapp.com>'

  def welcome(user_id)
    @user = User.find(user_id)
    mail({
             subject: 'Welcome to Omnipaste',
             from: 'Calin <calin@omnipasteapp.com>',
             to: @user.email
         })
  end
end
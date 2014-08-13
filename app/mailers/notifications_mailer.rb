class NotificationsMailer < BaseMailer
  def welcome(user_id)
    @user = User.find(user_id)
    mail({
             subject: 'Welcome to Omnipaste',
             from: 'Calin <calin@omnipasteapp.com>',
             to: @user.email
         })
  end
end
class NotificationsMailer < BaseMailer
  def welcome(user_id)
    @user = User.find(user_id)
    mail({
             subject: 'Welcome to Omnipaste',
             from: 'Calin <calin@omnipasteapp.com>',
             to: @user.email
         })
  end

  def install_instructions_android(user_id)
    @user = User.find(user_id)
    mail({
             subject: 'Omnipaste installation instructions',
             content_type: 'text/html',
             to: @user.email
         })
  end
end
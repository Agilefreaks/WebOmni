class NotificationsMailer < BaseMailer
  default template_path: "mailers/#{self.name.underscore}"

  def welcome(user_id)
    @user = User.find(user_id)
    @android_download_url = url_for(controller: :downloads, action: :android_client, email: @user.email)

    mail({
             subject: 'Welcome to Omnipaste',
             from: 'Calin <calin@omnipasteapp.com>',
             to: @user.email
         }) do |format|
      format.html { render template: 'mailers/notifications_mailer/welcome', layout: 'notifications_mailer' }
      format.text { render template: 'mailers/notifications_mailer/welcome' }
    end
  end
end
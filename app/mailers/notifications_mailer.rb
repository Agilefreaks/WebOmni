class NotificationsMailer < BaseMailer
  default template_path: "mailers/#{self.name.underscore}"

  def welcome(user_id)
    @user = User.find(user_id)
    @android_download_url = url_for(controller: :downloads, action: :android_client, email: @user.email)

    mail({
             subject: 'Welcome to Omnipaste',
             from: 'Calin <calin@omnipasteapp.com>',
             to: @user.email
         })
  end

  def invite(email)
    mail(
        {
            subject: '',
            from: 'Calin <calin@omnipasteapp.com>',
            to: email
        }
    )
  end
end
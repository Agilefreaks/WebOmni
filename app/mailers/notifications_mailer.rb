class NotificationsMailer < BaseMailer
  default template_path: "mailers/#{self.name.underscore}"

  def welcome(user_id)
    @user = User.find(user_id)
    @android_download_url = url_for(controller: :downloads, action: :android_client, email: @user.email)

    attachments.inline['button_windows.png'] = File.read(WebOmni::Application.assets.find_asset('mailers/button-windows.png').pathname)
    attachments.inline['button_android.png'] = File.read(WebOmni::Application.assets.find_asset('mailers/button-android.png').pathname)
    attachments.inline['button_authorization_code.png'] = File.read(WebOmni::Application.assets.find_asset('mailers/button-authorization-code.png').pathname)

    mail({
             subject: 'Welcome to Omnipaste',
             from: 'Calin <calin@omnipasteapp.com>',
             to: @user.email
         }) do |format|
      format.html { render template: 'mailers/notifications_mailer/welcome', layout: 'notifications_mailer' }
      format.text { render template: 'mailers/notifications_mailer/welcome' }
    end
  end

  def survey(email)
    @user = User.where(email: email).first
    return if @user.nil?

    mail({
             subject: 'You can help us make Omnipaste better',
             from: 'Calin <calin@omnipasteapp.com>',
             to: @user.email
         }) do |format|
      format.html { render template: 'mailers/notifications_mailer/survey', layout: 'notifications_mailer' }
      format.text { render template: 'mailers/notifications_mailer/survey' }
    end
  end
end

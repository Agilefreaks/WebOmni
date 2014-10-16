class BaseMailer < ActionMailer::Base
  default from: 'Omnipaste <team@omnipasteapp.com>'

  before_action :populate_inline_attachments

  private
  def populate_inline_attachments
    attachments.inline['background.jpg'] = File.read(WebOmni::Application.assets.find_asset('mailers/background.jpg').pathname)
    attachments.inline['logo.png'] = File.read(WebOmni::Application.assets.find_asset('mailers/logo.png').pathname)
    attachments.inline['icon_linkedin.png'] = File.read(WebOmni::Application.assets.find_asset('mailers/icon-linkedin.png').pathname)
    attachments.inline['icon_facebook.png'] = File.read(WebOmni::Application.assets.find_asset('mailers/icon-facebook.png').pathname)
    attachments.inline['icon_twitter.png'] = File.read(WebOmni::Application.assets.find_asset('mailers/icon-twitter.png').pathname)
  end
end
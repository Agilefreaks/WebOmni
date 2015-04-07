class BaseMailer < ActionMailer::Base
  default from: 'Omnipaste <team@omnipasteapp.com>'

  before_action :populate_inline_attachments

  private

  # rubocop:disable Metrics/AbcSize
  def populate_inline_attachments
    assets = WebOmni::Application.assets
    attachments.inline['background.jpg'] = File.read(assets.find_asset('mailers/background.jpg').pathname)
    attachments.inline['logo.png'] = File.read(assets.find_asset('mailers/logo.png').pathname)
    attachments.inline['icon_linkedin.png'] = File.read(assets.find_asset('mailers/icon-linkedin.png').pathname)
    attachments.inline['icon_facebook.png'] = File.read(assets.find_asset('mailers/icon-facebook.png').pathname)
    attachments.inline['icon_twitter.png'] = File.read(assets.find_asset('mailers/icon-twitter.png').pathname)
  end
end

class MinimalMenuCell < Cell::ViewModel
  include AbstractController::Translation
  include ActionView::Helpers::AssetUrlHelper
  include Sprockets::Rails::Helper

  self.assets_prefix = Rails.application.config.assets.prefix
  self.assets_environment = Rails.application.assets
  self.digest_assets = Rails.application.config.assets[:digest]

  builds do |model, _options|
    model ? AuthorizedMenuMinimalCell : UnauthorizedMenuMinimalCell
  end
end

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'https://www.omnipasteapp.com'

SitemapGenerator::Sitemap.create do
  add root_path, lastmod: Time.now, changefreq: 'daily'
  add "#{root_path}#feature-copy-paste", lastmod: Time.now, changefreq: 'daily'
  add "#{root_path}#feature-smart-action", lastmod: Time.now, changefreq: 'daily'
  add "#{root_path}#feature-notifications", lastmod: Time.now, changefreq: 'daily'
  add "#{root_path}#faq", lastmod: Time.now, changefreq: 'daily'
  add "#{root_path}#contact", lastmod: Time.now, changefreq: 'daily'

  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end

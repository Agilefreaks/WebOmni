namespace :users do
  desc 'Sync from web to api'
  task sync_web_api: :environment do
    User.all.each do |user|
      api_user = OmniApi::User.where(email: user.email).first
      api_user.update_attributes(first_name: user.first_name,
                                 last_name: user.last_name,
                                 email: user.email,
                                 image_url: user.image_url) if api_user
    end
  end
end

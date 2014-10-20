namespace :campaigns do
  desc 'Send survey email'
  task :survey, [:emails] => :environment do |_t, args|
    emails = args[:emails].split

    emails.each do |email|
      NotificationsMailer.survey(email).deliver
      p "Delivered to #{email}"
    end
  end
end

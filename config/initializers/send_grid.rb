ActionMailer::Base.smtp_settings = {
    :user_name => 'omnipaste',
    :password => 'ArtLine123',
    :domain => 'omnipasteapp.com',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
}
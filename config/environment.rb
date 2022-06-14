# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['MAILJET_LOGIN'],
  :password => ENV['MAILJET_PWD'],
  :domain => 'pizza-yolo.fr',
  :address => 'in-v3.mailjet.com',
  :tls => true,
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
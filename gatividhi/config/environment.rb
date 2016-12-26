# Load the rails application
require File.expand_path('../application', __FILE__)

ENV['GMAIL_USERNAME'] = 'perfectman0219@gmail.com'
ENV['GMAIL_PASSWORD'] = 'saint840123'

ENV['SMTP_USER_NAME'] = 'AKIAI7WA6LC6JTW4BQTA'
ENV['SMTP_PASSWORD'] = 'AhKwyxG9NzQh0PQBqFQXMB9Cyh7QXQ9lXlCP2+efk4+4'


# Initialize the rails application
Gatividhi::Application.initialize!

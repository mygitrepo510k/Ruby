# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Web::Application.initialize!

Premailer::Rails.config.merge!(preserve_styles: true,
                               remove_ids:      true)
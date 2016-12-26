require 'rubygems'
require 'spork'
require 'database_cleaner'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'
module PossibleJSDriver
  def require_js
    Capybara.current_driver = :webkit
  end

  def require_selenium
    Capybara.current_driver = :selenium
  end

  def teardown
    super
    Capybara.use_default_driver
  end
end

Spork.prefork do
  unless ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails' do
      formatter SimpleCov::Formatter::MultiFormatter[
        SimpleCov::Formatter::HTMLFormatter
      ]
    end
  end
  require 'rubygems'
  require 'factory_girl'
  #uncomment the following line to use spork with the debugger
  #require 'spork/ext/ruby-debug'


  ENV["RAILS_ENV"] = "test"
  require File.expand_path('../../config/environment', __FILE__)
  require 'rails/test_help'
  require 'minitest/hell'
  require "mocha/setup"
  require 'capybara/rails'
  require 'turn/autorun'
  require 'minitest-spec-context'
  require 'minitest/autorun'
  require 'pry-rescue/minitest'

  class ActiveSupport::TestCase
    include Sorcery::TestHelpers::Rails
    def setup
      GC.disable
    end
    def teardown
      GC.enable
    end
  end
  class ActionController::TestCase
    include Capybara::DSL
  end
  class ActionDispatch::IntegrationTest
    include Sorcery::TestHelpers::Rails
    include Rails.application.routes.url_helpers
    include Capybara::DSL
    include PossibleJSDriver
    self.use_transactional_fixtures = false
    def teardown
      DatabaseCleaner.clean
      Capybara.reset_sessions!
      Capybara.use_default_driver
    end
  end
  class ActionView::TestCase
    include Rails.application.routes.url_helpers
  end
  Geocoder.configure(lookup: :test)
  Geocoder::Lookup::Test.add_stub(
  "90210, Los Angeles, United States", [
    {
      'latitude'     => 34.052233,
      'longitude'    => -118.243682,
      'address'      => 'Los Angeles, USA',
      'state'        => 'California',
      'state_code'   => 'CA',
      'country'      => 'United States',
      'country_code' => 'US'
  }
  ]
  )
  DatabaseCleaner.strategy = :truncation
  module Sorcery
    module TestHelpers
      module Rails
        def login_user_post(user, password)
          page.driver.post(sessions_url, { username_or_email: user, password: password})
        end
        def login_integration_user(user)
          login_user_post(user.username, "secret")
        end
        def logout_integration_user(user)
          page.driver.delete(session_url(user.id))
        end
        def response_status
          page.driver.response.status
        end
      end
    end
  end

end

Spork.each_run do
  # This code will be run each time you run your specs.
  if ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails' do
      formatter SimpleCov::Formatter::MultiFormatter[
        SimpleCov::Formatter::HTMLFormatter
      ]
    end
  end
end

Turn.config do |c|
  c.format = :outline
  c.natural = true
end

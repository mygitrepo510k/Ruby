MountainLion::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.eager_load = false

  config.asset_host = 'http://localhost:3000'
  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  config.time_zone = "Pacific Time (US & Canada)"

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings  = {
    address: "localhost",
    port: 1025,
    domain: "hyedating.com"
  }
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000}
  # Do not compress assets
  config.assets.compress = false
  # Expands the lines which load the assets
  config.assets.debug = true
  config.sass.debug_info = true
  config.sass.line_comments = false
  PAPERCLIP_STORAGE_OPTIONS = { }

  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
    Bullet.bullet_logger = false
    Bullet.console = false
    Bullet.growl = true
    Bullet.rails_logger = true
    Bullet.airbrake = false
  end
end

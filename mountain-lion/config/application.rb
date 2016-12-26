require File.expand_path('../boot', __FILE__)
require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  # Bundler.require(*Rails.groups(assets: %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  Bundler.require(:default, :assets, Rails.env)
end

module MountainLion
  class Application < Rails::Application
    require Rails.root + 'lib/custom_public_exceptions'
    config.exceptions_app = CustomPublicExceptions.new Rails.public_path
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.cache_store = :redis_store, ENV['REDIS_URL'] || 'redis://localhost:6379/0' + '/cache', { expires_in: 90.minutes }
    config.encoding = "utf-8"

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql
    config.assets.precompile += %w( admin.js admin.css frontpage.css bootstrap_and_overrides.css custom.css)

    # Enable the asset pipeline
    config.assets.enabled = true

    # adding this because of heroku precompiling
    #config.assets.initialize_on_precompile = false

    config.generators do |g|
     g.template_framework :haml
     g.fixture_replacement = :factory_girl
    end
    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
    # <div class=\"popover\"><div class=\"arrow\"></div><div class=\"popover-inner\"><div class=\"popover-content\"><p></p></div></div></div>
  end
end

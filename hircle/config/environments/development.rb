Hircle::Application.configure do
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = true

  # Expands the lines which load the assets
  config.assets.debug = true

  config.after_initialize do
    ActiveMerchant::Billing::Base.mode=:test

    ::GATEWAY=ActiveMerchant::Billing::PaypalGateway.new(
        :login=> "mvjohn100_api1.hotmail.com",
        :password=>"1366968235",
        :signature=>"AiPC9BjkCyDFQXbSkoZcgqH3hpacAQBL1Rgm0ubwoxPOMBVESnguAf8F"
    )
  end

end

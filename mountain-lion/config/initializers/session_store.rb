# Be sure to restart your server when you modify this file.

if Rails.env.production?
  MountainLion::Application.config.session_store :redis_store, key: '_hyedating_session', domain: 'hyedating.com'
else
  MountainLion::Application.config.session_store :cookie_store
end

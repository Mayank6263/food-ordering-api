
# frozen_string_literal: true

# require_relative 'boot'
# require "sprockets/railtie"
# require 'rails'
# # Pick the frameworks you want:
# require 'active_model/railtie'
# require 'active_job/railtie'
# require 'active_record/railtie'
# require 'action_controller/railtie'
# require 'action_mailer/railtie'
# require 'action_view/railtie'
# require 'action_cable/engine'

require_relative "boot"

require "rails/all"
require "sprockets/railtie"
require "action_view/railtie"

Bundler.require(*Rails.groups)

module FoodOrderingApi
  class Application < Rails::Application
    # Ensure you're using a secret for session cookies, but use an ENV variable or manually set a key
    config.middleware.use "Rack::Session::Cookie", secret: ENV['SECRET_KEY_BASE'] || 'your-secret-key'

    # config.autoload_paths(ignore: %w(assets tasks))

    # Settings for API-only application
    # config.api_only = false
    config.active_job.queue_adapter = :sidekiq
    config.session_store :cookie_store, key: "_your_app_session"

    # Required for session management
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options
    config.middleware.delete ActionDispatch::Session::CookieStore
    config.middleware.delete ActionDispatch::Cookies
    config.middleware.delete ActionDispatch::Flash
    config.timezone = 'Asia/Kolkata'
  end
end

# # frozen_string_literal: true

# require_relative 'boot'

# require 'rails'
# # Pick the frameworks you want:
# require 'active_model/railtie'
# require 'active_job/railtie'
# require 'active_record/railtie'
# require 'action_controller/railtie'
# require 'action_mailer/railtie'
# require 'action_view/railtie'
# require 'action_cable/engine'
# # require "sprockets/railtie"
# require 'rails/test_unit/railtie'

# # Require the gems listed in Gemfile, including any gems
# # you've limited to :test, :development, or :production.
# Bundler.require(*Rails.groups)

# module FoodOrderingApi
#   class Application < Rails::Application
#     # Settings in config/environments/* take precedence over those specified here.
#     # Application configuration should go into files in config/initializers
#     # -- all .rb files in that directory are automatically loaded.

#     # Only loads a smaller set of middleware suitable for API only apps.
#     # Middleware like session, flash, cookies can be added back manually.
#     # Skip views, helpers and assets when generating a new resource.
#     config.api_only = true
#     config.active_job.queue_adapter = :sidekiq

#     # This also configures session_options for use below
#     config.session_store :cookie_store, key: "_your_app_session"

#     # Required for all session management (regardless of session_store)
#     config.middleware.use ActionDispatch::Cookies

#     config.middleware.use config.session_store, config.session_options
#     config.middleware.delete ActionDispatch::Session::CookieStore
#     config.middleware.delete ActionDispatch::Cookies
#     config.middleware.delete ActionDispatch::Flash
#     config.timezone = 'Asia/Kolkata'

#   end
# end

# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'

Bundler.require(*Rails.groups)

module FoodOrderingApi
  class Application < Rails::Application
    # Ensure you're using a secret for session cookies, but use an ENV variable or manually set a key
    config.middleware.use "Rack::Session::Cookie", secret: ENV['SECRET_KEY_BASE'] || 'your-secret-key'

    # Settings for API-only application
    config.api_only = true
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

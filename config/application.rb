require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Metrics
  class Application < Rails::Application

    config.assets.precompile += ['app.js']
    config.assets.precompile += ['/fonts']

    # config.middleware.insert_after ActiveRecord::QueryCache, ActionDispatch::Cookies
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
     # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    # config.secret_key_base =
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

     config.autoload_paths += %W[ #{config.root}/lib ]
     config.autoload_paths += %W[ #{config.root}/lib/support ]
     config.middleware.use ActionDispatch::Flash
     config.active_record.whitelist_attributes

    # We're an API-only app, so let's delete the session store.
      config.middleware.delete ActionDispatch::Session::CookieStore


      config.assets.initialize_on_precompile = false
      config.assets.enabled = true
  end
end


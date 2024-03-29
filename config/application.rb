require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Spot
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    #config.paths.add 'lib', eager_load: true #これを追加
    config.autoload_paths += %W(#{config.root}/lib/omniauth/strategies)
    #config.add_autoload_paths_to_load_path = false
    config.load_defaults 6.1

    config.i18n.default_locale = :ja
    #config.middleware.use OmniAuth::Strategies::Line
    #config.middleware.use OmniAuth::Strategies::Facebook
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AlphaBlog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
    #Configuration to enable custom fonts
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    #Set timezone to EST
    config.time_zone = "Eastern Time (US & Canada)"

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales','**', '*.{rb,yml}')]
    config.i18n.default_locale = :fr
    config.i18n.available_locales = [:en, :fr]

  end
end

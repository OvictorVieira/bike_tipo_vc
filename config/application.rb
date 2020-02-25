require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BikeTipoVc
  class Application < Rails::Application
    config.load_defaults 6.0

    config.i18n.locale = 'pt-BR'
    config.i18n.default_locale = 'pt-BR'
    config.i18n.available_locales = 'pt-BR'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**','*.{rb,yml}').to_s]

    config.app = OpenStruct.new
    config.app.postgres = OpenStruct.new
    config.app.postgres.user = Rails.application.credentials[:postgres][Rails.env.to_sym][:user]
    config.app.postgres.password = Rails.application.credentials[:postgres][Rails.env.to_sym][:password]
  end
end

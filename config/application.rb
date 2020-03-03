require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BikeTipoVc
  class Application < Rails::Application
    config.load_defaults 6.0

    config.app = OpenStruct.new
    config.app.redis = OpenStruct.new
    config.app.postgres = OpenStruct.new
    config.app.postgres.user = Rails.application.credentials[:postgres][Rails.env.to_sym][:user]
    config.app.postgres.password = Rails.application.credentials[:postgres][Rails.env.to_sym][:password]
    config.app.postgres.database = Rails.application.credentials[:postgres][Rails.env.to_sym][:database]
    config.app.postgres.host = Rails.application.credentials[:postgres][Rails.env.to_sym][:host]
    config.app.redis.host = Rails.application.credentials[:redis][Rails.env.to_sym][:host]
  end
end

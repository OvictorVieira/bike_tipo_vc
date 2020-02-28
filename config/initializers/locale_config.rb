Rails.applicationconfig.i18n.locale = 'pt-BR'
Rails.applicationconfig.i18n.default_locale = 'pt-BR'
Rails.applicationconfig.i18n.available_locales = 'pt-BR'

Rails.applicationconfig.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**','*.{rb,yml}').to_s]
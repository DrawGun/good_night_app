I18n.load_path += Dir[Application.root.concat('/config/locales/**/*.yml')]
I18n.available_locales = %i[en]
I18n.default_locale = :en

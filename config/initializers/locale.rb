# Load locale files from nested directories inside config/locales
I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]

# Permitted locales available for the application
I18n.available_locales = %i[en de]

# Set default locale to German
I18n.default_locale = :de

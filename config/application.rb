require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Wed
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.app_domain = 'wedcity.pro'
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.encoding = "utf-8"
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.available_locales = [:uk, :ru]
    config.i18n.default_locale = :uk
    config.action_mailer.delivery_method = :smtp
  end

  # ActionMailer::Base.smtp_settings = {
  #   address:              "smtp.gmail.com",
  #   port:                 587,
  #   domain:               "146.185.151.232",
  #   user_name:            "wedcity.pro@gmail.com",
  #   password:             "wed_pas8",
  #   authentication:       "plain",
  #   enable_starttls_auto: true
  # }

  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    # address:              'smtp.gmail.com',
    # port:                 587,
    # domain:               'gmail.com',
    # user_name:            ENV['GMAIL_USER'],
    # password:             ENV['GMAIL_PASS'],
    # authentication:       :plain,
    # enable_starttls_auto: true
    port:           '587',
    address:        'smtp.mandrillapp.com',
    user_name:      'wedcity',
    password:       ENV['MANDRILL_KEY'],
    domain:         'wedcity.pro',
    authentication: :plain
  }
end

Wed::Application.config.middleware.use ExceptionNotification::Rack,
  :email => {
    :email_prefix => "[WedCity ERROR #{Rails.env.to_s.upcase}] ",
    :sender_address => %{"Notifier" <notifier@wedcity.pro>},
    :exception_recipients => %w{wedcity.pro@gmail.com}
  }
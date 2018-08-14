require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"

my_rails_root = File.expand_path('../..', __FILE__)
require "#{my_rails_root}/lib/global_constant/base.rb"
Dir["#{my_rails_root}/lib/global_constant/*.rb"].each {|file| require file }

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OstCmsApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Local machine timezone
    config.time_zone = YAML.load_file(open(Rails.root.to_s + '/config/time_zone.yml'))['rails_time_zones'][Rails.env.to_s]
    # Local machine timezone
    config.active_record.default_timezone = :local

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths << "#{config.root}/lib/"
    config.eager_load_paths << "#{config.root}/lib/"

    # Not Needed as of now
    config.middleware.delete Rack::Sendfile

    # Custom log formatter
    require_relative('../lib/custom_log_formatter')
    config.log_level = :debug
    config.log_formatter = CustomLogFormatter.new

  end
end

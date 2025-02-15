require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "rails/test_unit/railtie"

require 'view_component/engine'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BidGenerator
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"

    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.helper false
      g.fixture_replacement :factory_bot
    end

    config.view_component.preview_paths << "#{Rails.root}/spec/components/previews"
    config.active_storage.variant_processor = :vips
    config.action_mailer.deliver_later_queue_name = :default
    config.time_zone = 'Pacific Time (US & Canada)'

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.active_support.disable_to_s_conversion = true
    config.active_support.cache_format_version = 7.0
  end
end

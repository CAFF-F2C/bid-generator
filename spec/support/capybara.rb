require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'capybara/email/rspec'

Capybara.default_driver = :rack_test
Capybara.javascript_driver = :selenium_chrome_headless
Capybara.server = :puma, {Silent: true}
Capybara.always_include_port = true
Capybara.default_normalize_ws = true
Capybara.default_max_wait_time = 10
Capybara.enable_aria_label = true
Capybara.disable_animation = true

Capybara.register_driver :selenium_chrome_headless do |app|
  Capybara::Selenium::Driver.load_selenium
  browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.args << '--window-size=1920,1080'
    opts.args << '--force-device-scale-factor=0.95'
    opts.args << '--headless'
    opts.args << '--disable-gpu'
    opts.args << '--disable-site-isolation-trials'
    opts.args << '--no-sandbox'
  end
  browser_options.add_preference(:download, prompt_for_download: false, default_directory: Rails.root.join("tmp/capybara_downloads#{ENV['TEST_ENV_NUMBER']}").to_s)
  browser_options.add_preference(:browser, set_download_behavior: {behavior: 'allow'})
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
end

RSpec.configure do |config|
  config.include Capybara::RSpecMatchers, type: :request
  config.before(:each, type: :feature) { Capybara.current_driver = :rack_test }
  config.before(:each, type: :feature, js: true) { Capybara.current_driver = :selenium_chrome_headless }
  config.before(:each, type: :system) { driven_by(:rack_test) }
  config.before(:each, type: :system, js: true) { driven_by(:selenium_chrome_headless) }
end

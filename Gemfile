source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4'

gem 'dotenv-rails', groups: [:test, :development]

gem 'administrate'
gem 'aws-sdk-rails', '~> 3'
gem 'aws-sdk-s3', require: false
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'connection_pool'
gem 'devise'
gem 'hiredis'
gem 'inline_svg'
gem 'jbuilder', '~> 2.7'
gem 'paranoia'
gem 'pundit'
gem 'redis'
gem 'rspec'
gem 'ruby-vips'
gem 'sablon'
gem 'sass-rails', '>= 6'
gem 'stimulus-rails'
gem 'tailwindcss-rails', '~> 0.3.3'
gem 'turbo-rails'
gem 'view_component', require: 'view_component/engine'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'annotate', '~> 3.0'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'jasmine'
  gem 'license_finder', '~> 6.0'
  gem 'teaspoon-jasmine'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'pivotal_git_scripts'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'axe-core-capybara'
  gem 'axe-core-rspec'
  gem 'capybara', '~> 3.0'
  gem 'capybara-email', '~> 3.0'
  gem 'capybara-screenshot', '~> 1.0', require: false
  gem 'database_cleaner-active_record'
  gem 'pundit-matchers', '~> 1.6'
  gem 'rspec-activemodel-mocks'
  gem 'rspec-collection_matchers'
  gem 'rspec-html-matchers'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'timecop'
  gem 'vcr'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

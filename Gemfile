source 'https://rubygems.org'

ruby "2.2.0"

gem 'rails', '~> 4.2.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem "devise"
gem "cancan"
gem "haml-rails"
gem 'coffee-rails'
gem 'gmaps4rails', '~> 1.5.6'
gem 'geocoder'
gem "unicorn"
gem "rack-timeout", '0.0.4' # https://github.com/heroku/rack-timeout/issues/55
gem "sidekiq"
gem "sinatra", require: false # Required for Sidekiq web interface

gem "devise-async"
gem "gravatar-ultimate"
# render markdown
gem "redcarpet", "~> 1.17.2"
gem "icalendar"

# parse urls
gem "addressable"

gem "twitter"

# quick and easy metrics
gem "prosperity"

group :development do
  gem 'letter_opener'
  gem 'quiet_assets'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# Gems used only for assets and not required
# in production environments by default.
gem 'sass-rails',   '~> 4.0.0' # v5 breaks CI
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', :platforms => :ruby
gem "uglifier", '~> 2.1.1'

gem 'httparty'

#gem 'compass-rails', '1.0.3'

# Allow compass to support Rails 4.0.0
gem 'compass-rails'
gem 'zurb-foundation', '3.0.9'
gem 'modular-scale', '1.0.6'

gem 'jquery-rails'
gem 'chronic'

# Allow use of sockets for mobile support
gem 'socket.io-client-simple'
# Set up push notifications for iOS apps
gem 'houston'

group :test do
  gem "factory_girl_rails"
  gem "timecop"
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false # code coverage tool
  gem "database_cleaner"
  gem 'email_spec'
  gem "webmock"
end

group :test, :development do
  gem "rspec-rails"
  gem 'capybara'
  gem 'poltergeist'
  gem 'pry-rails'
  gem 'sqlite3'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

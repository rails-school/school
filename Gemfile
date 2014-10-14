source 'https://rubygems.org'

ruby "2.1.1"

gem 'rails', '~> 4.1.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem "devise", "~> 3.2.2"
gem "cancan"
gem "haml-rails"
gem 'coffee-rails', '~> 4.0.0'
gem 'gmaps4rails', '~> 1.5.6'
gem 'geocoder'
gem "unicorn"
gem "rack-timeout"
gem "sidekiq"
gem "asset_sync"
gem "devise-async"
gem "gravatar-ultimate"
# render markdown
gem "redcarpet", "~> 1.17.2"
gem "icalendar"

# parse urls
gem "addressable"

gem "twitter"
gem "protected_attributes"

# quick and easy metrics
gem "prosperity", github: "smathieu/prosperity"

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
gem 'sass-rails',   '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', :platforms => :ruby
gem "uglifier", '~> 2.1.1'


#gem 'compass-rails', '1.0.3'

# Allow compass to support Rails 4.0.0
gem 'compass-rails'
gem 'zurb-foundation', '3.0.9'
gem 'modular-scale', '1.0.6'

gem 'jquery-rails'

group :test do
  gem "cucumber-rails", :require => false
  gem "factory_girl_rails"
  gem "timecop"
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false # code coverage tool
  gem "database_cleaner"
  gem "forgery"
  gem 'email_spec'
end

group :test, :development do
  gem "rspec-rails"
  gem 'capybara'
  gem 'poltergeist'
  gem 'pry-rails'
  gem 'pry-plus'
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

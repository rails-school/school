source 'https://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem "devise"
gem "haml-rails"
gem 'coffee-rails', '~> 3.2.1'
gem "contenteditable", :github => 'micmmakarov/contenteditable', :branch => :master
gem 'gmaps4rails'

group :development do
  gem 'pry'
  gem 'pry-nav'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  gem "uglifier"
  gem 'compass-rails', '~> 1.0.3'
  gem 'zurb-foundation', '~> 3.0.9'
end

gem 'jquery-rails'

group :test do
  gem "cucumber-rails", :require => false
  gem "factory_girl_rails"
  gem "timecop"
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false # code coverage tool
  gem "database_cleaner"
  gem "forgery"
end

group :test, :development do
  gem "rspec-rails"
  gem 'pry'
  gem 'pry-nav'
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

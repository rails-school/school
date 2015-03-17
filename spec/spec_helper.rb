require 'simplecov'
SimpleCov.start "rails"

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require "email_spec"
require 'capybara/poltergeist'
require_relative 'helpers'
require 'sidekiq/testing'
Sidekiq::Testing.inline!
WebMock.allow_net_connect!
require "support/request_stubs/fake_code_wars"
require "support/request_stubs/fake_send_grid"
require "support/request_stubs/fake_bridge_troll"

ActiveRecord::Migration.maintain_test_schema!

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.after :each do
    Capybara.reset_sessions!
    DatabaseCleaner.clean
  end
  config.include Helpers
  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)
  config.include Devise::TestHelpers, type: :controller
  config.infer_spec_type_from_file_location!

  config.expect_with(:rspec) { |c| c.syntax = [:should, :expect] }
end

Capybara.register_driver :poltergeist do |app|
    options = {
        :phantomjs_options => ['--load-images=no', '--disk-cache=false'],
    #    debug: true
    }
    Capybara::Poltergeist::Driver.new(app, options)
end
Capybara.javascript_driver = :poltergeist

Geocoder.configure(:lookup => :test)

Geocoder::Lookup::Test.set_default_stub(
  [
    {
      'latitude'     => 40.7143528,
      'longitude'    => -74.0059731,
      'address'      => 'New York, NY, USA',
      'state'        => 'New York',
      'state_code'   => 'NY',
      'country'      => 'United States',
      'country_code' => 'US'
    }
  ]
)

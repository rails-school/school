RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end

Devise.stretches = 1

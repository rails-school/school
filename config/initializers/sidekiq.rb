unless Rails.env.production?
  require 'sidekiq/testing/inline'
end

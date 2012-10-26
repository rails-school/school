require 'factory_girl'

FactoryGirl.define do

  factory :user do |u|
    u.name                   "Test User that loves beer"
    u.email                  "light@beer-is-good.com"
    u.password               "draft"
    u.password_confirmation  "draft"
  end

end

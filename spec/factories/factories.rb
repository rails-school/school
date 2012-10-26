require 'factory_girl'

FactoryGirl.define do

  factory :user do |u|
    u.name                   "Test User that loves beer"
    u.email                  "light@beer-is-good.com"
    u.password               "draft1"
    u.password_confirmation  "draft1"
    admin                    false
  end

  factory :admin, class: User do |u|
    u.name                   "this is an admin"
    u.email                  "light1@beer-is-good.com"
    u.password               "draft1"
    u.password_confirmation  "draft1"
    admin                    true
  end

  factory :lesson do |l|
    l.title              "some random lesson how to make animal orgy on mondays"
    l.description        "light@beer-is-good.com"
    l.date               Date.today
  end

end

require 'factory_girl'

FactoryGirl.define do

  factory :user do |u|
    u.name                   "Test User that loves beer"
    sequence(:email) { |i| "user_#{i}@example.com"}
    u.password               "draft1"
    u.password_confirmation  "draft1"
    u.subscribe               true
    u.admin                   false
    school
  end

  factory :admin, class: User do |u|
    sequence(:name) { |i| "this is admin ##{i}" }
    u.email                  "light1@test.railsschool.org"
    u.password               "draft1"
    u.password_confirmation  "draft1"
    admin                    true
  end

  factory :attendance do
    lesson
    user
  end

  factory :lesson do |l|
    sequence(:title) { |i| "Lesson ##{i}" }
    l.description        "light@beer-is-good.com"
    l.start_time         Date.current + 1.day
    l.end_time           Date.current + 1.day + 2.hours
    venue
  end

  factory :next_month_lesson, class: Lesson do |l|
    l.title              "some random lesson how to make animal orgy on mondays"
    l.description        "light@beer-is-good.com"
    l.start_time         Date.current + 1.month + 1.day
    l.end_time           Date.current + 1.month + 1.day + 2.hours
    venue
  end

  factory :school do
    sequence(:name) { |i| "School ##{i}" }
    sequence(:slug) { |i| "school_#{i}" }
    timezone "Pacific Time (US & Canada)"
  end

  factory :venue do
    sequence(:name) { |i| "Venue ##{i}" }
    sequence(:zip) { |i| "019"+(i<10?"0":"")+i.to_s }
    address "100 Main St."
    state "Massachusetts"
    school
  end

end

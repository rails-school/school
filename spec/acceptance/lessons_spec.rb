require 'spec_helper'

feature %q{
  As a user
  I want to be able to RSVP
  So organizers can see how many people go
} do

  background do
    @user = FactoryGirl.create(:user)
    @lesson = FactoryGirl.create(:lesson)
    visit "/"
    click_link "Login"
    fill_in "user[email]", :with => @user.email
    fill_in "user[password]", :with => "draft1"
    click_button "Sign in"
  end


  scenario "RSVP clicking RSVP button", :js => true do
    click_link "RSVP!"
    Attendance.all.count.should == 1
    page.should have_css(".pressed")
  end


end


feature %q{
  As a user
  I cannot RSVP if I am not logged in
  So organizers know who exactly goes
} do

  background do
    visit "/"
  end

  scenario "trying RSVP clicking RSVP button", :js => true do
    click_link "RSVP!"
    Attendance.all.count.should == 0
    page.should_not have_css(".pressed")
  end


end


feature %q{
  As a website
  I want to make sure,
  That when admin creates a lesson,
  Slug is generated
  So link to the lesson is accessible
} do

  background do
    @admin = FactoryGirl.create(:admin)
    visit "/"
    click_link "Login"
    fill_in "user[email]", :with => @admin.email
    fill_in "user[password]", :with => "draft1"
    click_button "Sign in"
  end

  scenario "creating a lesson", :js => true do
    l = Lesson.new
    l.title = "Funny lesson how to eat bad veggie burgers"
    l.description = "Yooou!"
    l.save!
    lessons = Lesson.all
    lessons.count.should == 1
    lessons.first.slug.should == "funny_lesson_how_to_eat_bad_veggie_burgers"
  end


end
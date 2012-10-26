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
    page.should have_css(".pressed")
  end


end


feature %q{
  As a user
  I cannot RSVP if I am not logged in
  So organizers know who exactly logged in
} do

  background do
    visit "/"
  end


  scenario "trying RSVP clicking RSVP button", :js => true do
    click_link "RSVP!"
    page.should_not have_css(".pressed")
  end


end
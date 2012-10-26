require 'spec_helper'

feature %q{
  As a user
  I want to be able to log out
  So other users can log in
} do

  background do
    @user = FactoryGirl.create(:user)
    visit "/"
    click_link "Login"
    fill_in "user[email]", :with => @user.email
    fill_in "user[password]", :with => "draft1"
    click_button "Sign in"
  end


  scenario "Log out by clicking link", :js => true do
    click_link "Logout"
    page.should have_link("Login")
  end


end

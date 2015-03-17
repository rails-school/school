require 'spec_helper'

feature %q{
  As a user
  I want to be able to sign up
  So I can participate
} do

  background do
    create(:venue)
    visit root_path
    click_link "Sign up"
  end

  scenario "Sign up with valid data" do
    fill_in "user[email]", with: "stewie@example.com"
    fill_in "user[name]", with: "Stewie"
    fill_in "user[password]", with: "draft1"
    fill_in "user[password_confirmation]", with: "draft1"
    fill_in "user[homepage]", with: "google.com"
    fill_in "user[codewars_username]", with: "stewie2000"
    fill_in "user[bridge_troll_user_id]", with: "999"
    click_button "Sign up"
    within ".center-column" do
      page.should_not have_content "Sign up"
    end
    user = User.last.reload
    user.name.should == "Stewie"
    user.email.should == "stewie@example.com"
    user.homepage.should == "http://google.com"
    user.codewars_username.should == "stewie2000"
    user.bridge_troll_user_id.should == "999"
  end

  scenario "Email has already been taken", js: true do
    create(:user, email: "stewie@example.com")
    User.count.should == 1
    fill_in "user[email]", with: "stewie@example.com"
    fill_in "user[name]", with: "Stewie"
    fill_in "user[password]", with: "draft1"
    fill_in "user[password_confirmation]", with: "draft1"
    fill_in "user[homepage]", with: "google.com"
    click_button "Sign up"
    page.should have_content "Email has already been taken"
    User.count.should == 1
  end
end

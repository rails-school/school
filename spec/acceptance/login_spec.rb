require 'spec_helper'

feature %q{
  As a user
  I want to be able to log out
  So other users can log in
} do

  background do
    @user = FactoryGirl.create(:user)
    venue = FactoryGirl.create(:venue)
    sign_in_manually(@user)
  end

  scenario "Log out by clicking link", :js => true do
    click_link "Logout"
    page.should have_link("Login")
  end
end

feature %q{
  As a user
  If I am mistaken with the password
  I should see that message
} do

  scenario "see the message", :js => true do
    @user = FactoryGirl.create(:user)
    venue = FactoryGirl.create(:venue)
    visit "/"
    click_link "Login"
    fill_in "user[email]", :with => @user.email
    fill_in "user[password]", :with => "wrong_password"
    # poltergeist interittently doesn't trigger javascript unless we do this
    find_button("Sign in").trigger(:click)
    page.should have_content("Invalid email or password.")
  end
end

feature %q{
  As a user
  If I log in while on a particular page
  I want to return to that page immediately
} do

  scenario "login on about page", js: true do
    user = create(:user)
    venue = create(:venue)
    visit about_path
    click_link "Login"
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: "draft1"
    # poltergeist interittently doesn't trigger javascript unless we do this
    find_button("Sign in").trigger(:click)
    page.should have_content("Signed in successfully")
    URI.parse(current_url).path.should == about_path
  end
end

feature %q{
  As a user
  I should be able to unsubscribe
  if I have a link
} do

  background do
    @user = FactoryGirl.create(:user)
    @venue = FactoryGirl.create(:venue)
  end

  scenario "unsubscribe" do
    @user.subscribe_lesson_notifications.should == true
    visit lesson_unsubscribe_path(code: @user.unsubscribe_token)
    page.should have_content("unsubscribed")
    @user.reload.subscribe_lesson_notifications.should == false
  end
end

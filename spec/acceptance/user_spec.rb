require 'spec_helper'

feature %q{
  As a user
  I want to be able to change my email
  So I can set a new address if I lose my old one
} do

  background do
    @user = FactoryGirl.create(:user, :name => "Stewie", :email => "bogus@example.com")
    venue = FactoryGirl.create(:venue)
    sign_in_manually(@user)
  end

  scenario "Edit my profile", :js => true do
    @user.subscribe_lesson_notifications.should == true
    @user.subscribe_badge_notifications.should == true

    click_link "Stewie"
    click_link "Edit"
    within ".center-column" do
      fill_in "user[email]", with: "stewie@example.com"
      fill_in "user[homepage]", with: "example.com"
      fill_in "user[bridge_troll_user_id]", with: "1111"
      uncheck "user[subscribe_lesson_notifications]"
      uncheck "user[subscribe_badge_notifications]"
      click_button "Save"
    end
    page.should have_content "User was successfully updated."
    @user.reload.email.should == "stewie@example.com"
    @user.homepage.should == "http://example.com"
    @user.bridge_troll_user_id.should == "1111"
    @user.subscribe_lesson_notifications.should == false
    @user.subscribe_badge_notifications.should == false
  end
end

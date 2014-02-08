require 'spec_helper'

feature %q{
  As a user who's forgotten her password
  I want to be able to reset my password
  So that I can regain access to my account
} do

  scenario "Reset my password" do
    create(:venue)
    user = create(:user)
    visit root_path
    click_link "Login"
    click_link "Forgot your password?"
    URI.parse(current_url).path.should == new_user_password_path
    page.should have_button "Send me reset password instructions"
    fill_in "Email", with: user.email
    click_button "Send me reset password instructions"
    page.should have_content("You will receive an email with instructions about how to reset your password in a few minutes.")

    unread_emails_for(user.email).size.should == 1
    msg = open_email(user.email)
    uri = URI.parse(links_in_email(msg).first)
    visit "#{uri.path}?#{uri.query}"

    page.should have_content("Change your password")
    fill_in "New password", with: "sc@ll0p"
    fill_in "Confirm new password", with: "sc@ll0p"
    click_button "Change my password"
    page.should have_content "Your password was changed successfully. You are now signed in."
    page.should have_content user.name
    click_link "Logout"
    page.should have_no_content user.name
    
    click_link "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: "sc@ll0p"
    click_button "Sign in"
    page.should have_content "Signed in successfully."
    page.should have_content user.name
  end
end

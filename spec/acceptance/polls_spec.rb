require 'spec_helper'

feature %q{
  As an admin
  I want to be able to create new polls
} do

  background do
    @user = FactoryGirl.create(:admin)
    venue = FactoryGirl.create(:venue)
    visit root_path
    click_link "Login"
    fill_in "user[email]", :with => @user.email
    fill_in "user[password]", :with => "draft1"
    click_button "Sign in"
    visit "/polls"
  end


  scenario "create a poll", :js => true do
    visit new_poll_path
    fill_in "Question", :with => "Should a bear drink beer or have food with an elephant?"
    page.should have_css("h2", :text => "Please save this poll first to add answers", :visible => true)
    click_button "Save"
    page.should have_no_css("h2", :text => "Please save this pall first to add answers", :visible => true)

    answer_text = "we should ask squirrels"
    fill_in "answer_text", :with => answer_text
    click_button "Add answer"
    page.should have_css("h5", :text => answer_text, :visible => true)
    page.find(".delete-answer", :visible => true).click
    page.should have_no_css("h5", :text => answer_text, :visible => true)

    click_button "Save"
    page.should have_css("p", :text => "Poll was successfully updated.", :visible => true)
  end

end

feature %q{
  As a user
  I want to be able to see the polls
  And vote for answers
} do

  background do
    stub_current_school
    FactoryGirl.create(:poll, published: true)
    @user = FactoryGirl.create(:user)
    sign_in_manually(@user)
  end

  scenario "poll is visible and votable", :js => true do
    save_and_open_page
    page.should have_css(".polls", :visible => true)
  end

end

feature %q{
  As a website
  I want to make sure,
  That non-admin user
  Can't create polls
} do

  background do
    @user = FactoryGirl.create(:user)
    venue = FactoryGirl.create(:venue)
    @user.school = venue.school
    sign_in_manually @user
  end

  scenario "Non-admin user is trying to access polls", :js => true do
    visit new_poll_path
    uri = URI.parse(current_url)
    uri.path.should == root_path
  end

end

require 'spec_helper'

feature %q{
  As a user
  I want to be able to RSVP
  So organizers can see how many people go
} do

  background do
    @user = FactoryGirl.create(:user)
    @lesson = FactoryGirl.create(:lesson)
    visit root_path
    click_link "Login"
    fill_in "user[email]", :with => @user.email
    fill_in "user[password]", :with => "draft1"
    click_button "Sign in"
  end


  scenario "RSVP clicking RSVP button", :js => true do
    page.find(".announce").click_link "RSVP!"
    page.should have_css(".pressed")
    Attendance.all.count.should == 1
  end
end

feature %q{
  As a user
  I want to be able to unRSVP
  So organizers can see how many people go
} do

  background do
    @user = FactoryGirl.create(:user)
    @lesson = FactoryGirl.create(:lesson)
    visit root_path
    click_link "Login"
    fill_in "user[email]", :with => @user.email
    fill_in "user[password]", :with => "draft1"
    click_button "Sign in"
  end


  scenario "RSVP clicking RSVP button", :js => true do
    page.find(".announce").click_link "RSVP!"
    page.find(".announce").click_link "unRSVP"
    page.should_not have_css(".pressed")
    Attendance.all.count.should == 0
  end


end



feature %q{
  As a user
  I cannot RSVP if I am not logged in
  So organizers know who exactly goes
} do

  background do
    @lesson = FactoryGirl.create(:lesson)
    visit "/"
  end

  scenario "trying RSVP clicking RSVP button", :js => true do
    page.find(".announce").click_link "RSVP!"
    page.should_not have_css(".pressed")
    Attendance.all.count.should == 0
  end


end


feature %q{
  As a website
  I want to make sure,
  That when lesson is saved
  Slug is generated
} do

  background do
  end

  scenario "creating a lesson", :js => true do
    l = Lesson.new
    l.title = "Funny lesson how to eat bad veggie burgers"
    l.description = "Yooou!"
    l.save!
    lessons = Lesson.all
    lessons.count.should == 1
    lessons.first.slug.should == "funny-lesson-how-to-eat-bad-veggie-burgers"
  end


end

feature %q{
  As a website
  I want to make sure,
  That the admin can create lessons
  So the admin can create lessons
} do

  background do
    @admin = FactoryGirl.create(:admin)
    visit root_path
    click_link "Login"
    fill_in "user[email]", :with => @admin.email
    fill_in "user[password]", :with => "draft1"
    click_button "Sign in"
  end

  scenario "creating a new upcoming lesson", :js => true do
    visit "/l/new"
    fill_in "lesson[title]", :with => "some random topic"
    fill_in "lesson[summary]", :with => "some random summary"
    fill_in "lesson[description]", :with => "some random description"
    select "#{Date.current.year + 1}", :form => "lesson[date(1i)]"
    click_button "Save"
    lessons = Lesson.all
    lessons.count.should == 1

    visit "/"
    page.should have_content "some random topic"
    page.should have_content "some random summary"
  end

end

feature %q{
  As a website
  I want to make sure,
  That some random user
  Can't create lessons
} do

  background do
    @user = FactoryGirl.create(:user)
    visit root_path
    click_link "Login"
    fill_in "user[email]", :with => @user.email
    fill_in "user[password]", :with => "draft1"
    click_button "Sign in"
  end

  scenario "Random user is trying to access create lesson address", :js => true do
    visit new_lesson_path
    uri = URI.parse(current_url)
    uri.path.should == root_path
  end

end

require 'spec_helper'


feature %q{
  As a user
  I want to be able to RSVP
  So organizers can see how many people go
} do

  background do
    @user = FactoryGirl.create(:user)
    @lesson = FactoryGirl.create(:lesson)
    sign_in @user
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
    sign_in @user
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
    sign_in @admin
  end

  scenario "creating a new upcoming lesson", :js => true do
    visit "/l/new"
    fill_in "lesson[title]", :with => "some random topic"
    fill_in "lesson[summary]", :with => "some random summary"
    fill_in "lesson[description]", :with => "some random description"
    fill_in "lesson[start_time]", :with => "6:30pm"
    fill_in "lesson[end_time]", :with => "8:15pm"
    fill_in "lesson[date]", :with => (Date.current + 1.day).to_s
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
    sign_in @user
  end

  scenario "Random user is trying to access create lesson address", :js => true do
    visit new_lesson_path
    uri = URI.parse(current_url)
    uri.path.should == root_path
  end

end

feature %q{
  As a teacher
  When I have a lesson coming up
  I want to be send an email blast
  So that hopefully some students come to my lesson
} do

  background do
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin, :subscribe => false)
    @lesson = FactoryGirl.create(:lesson)
    sign_in @admin
  end

  scenario "Admin notifies users" do
    @lesson.reload.notification_sent_at.should be_nil
    visit lesson_path(@lesson)
    NotificationMailer.should_receive(:lesson_notification).with(@lesson.id, @user.id, @admin.id)
    click_link "Notify subscribers"
    page.should have_content("Subscriber notification emails sent")
    @lesson.reload.notification_sent_at.should be_within(1.minute).of(Time.now)
    page.should_not have_link("Notify subscribers")
  end
end

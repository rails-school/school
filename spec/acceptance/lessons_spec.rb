require 'spec_helper'


feature %q{
  As a user
  I want to be able to RSVP
  So organizers can see how many people go
} do

  background do
    @user = FactoryGirl.create(:user)
    @lesson = FactoryGirl.create(:lesson)
    @user.school = @lesson.venue.school
    sign_in_manually @user
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
    sign_in_manually @user
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
    @admin = create(:admin)
    @venue = create(:venue)
    sign_in_manually @admin
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

    visit lesson_path(Lesson.last)
    within "ul.teachers" do
      page.should have_content @admin.name
    end
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
    venue = FactoryGirl.create(:venue)
    @user.school = venue.school
    sign_in_manually @user
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
    @user.school = @lesson.venue.school; @user.save!
    sign_in_manually @admin
  end

  scenario "Admin notifies users without setting tweet message" do
    @lesson.reload.notification_sent_at.should be_nil
    visit lesson_path(@lesson)
    NotificationMailer.should_receive(:lesson_notification).with(@lesson.id, @user.id, @admin.id)
    status = /Shame on #{@admin.name.split(" ").first} for this boring message. The next class is "#{@lesson.title}". http/
    Twitter.should_receive(:update).with(status)
    click_link "Notify subscribers"
    page.should have_content("Subcribers notified and tweet tweeted")
    @lesson.reload.notification_sent_at.should be_within(1.minute).of(Time.now)
    page.should_not have_link("Notify subscribers")
  end

  scenario "Admin only notifies users in the lesson's school" do
    user_2 = FactoryGirl.create(:user, school: @user.school)
    user_3 = FactoryGirl.create(:user)

    @lesson.reload.notification_sent_at.should be_nil
    visit lesson_path(@lesson)
    NotificationMailer.should_receive(:lesson_notification).with(@lesson.id, @user.id, @admin.id)
    NotificationMailer.should_receive(:lesson_notification).with(@lesson.id, user_2.id, @admin.id)
    NotificationMailer.should_not_receive(:lesson_notification).with(@lesson.id, user_3.id, @admin.id)
    status = /Shame on #{@admin.name.split(" ").first} for this boring message. The next class is "#{@lesson.title}". http/
    Twitter.should_receive(:update).with(status)
    click_link "Notify subscribers"
    page.should have_content("Subcribers notified and tweet tweeted")
    @lesson.reload.notification_sent_at.should be_within(1.minute).of(Time.now)
    page.should_not have_link("Notify subscribers")
  end

  scenario "Admin notifies users with custom tweet message" do
    @lesson.reload.notification_sent_at.should be_nil
    visit edit_lesson_path(@lesson)
    fill_in "lesson[tweet_message]", with: "Check it out! >> {{url}} << W00t!"
    click_button "Save"
    NotificationMailer.should_receive(:lesson_notification).with(@lesson.id, @user.id, @admin.id)
    status = /Check it out! >> http.* << W00t!/
    Twitter.should_receive(:update).with(status)
    click_link "Notify subscribers"
    page.should have_content("Subcribers notified and tweet tweeted")
    @lesson.reload.notification_sent_at.should be_within(1.minute).of(Time.now)
    page.should_not have_link("Notify subscribers")
  end
end

feature %q{
  As a user
  I see a calendar for the next month
  If there no more lessons in this month
} do

  background do
    @user = FactoryGirl.create(:user)
    @lesson = FactoryGirl.create(:next_month_lesson)
    @user.school = @lesson.venue.school
    sign_in_manually @user
  end


  scenario "RSVP clicking RSVP button", :js => true do
    page.should_not have_content(Date.today.strftime("%B").upcase)
    page.should have_content((Date.today+1.month).strftime("%B").upcase)
  end


end

# coding: utf-8
require 'spec_helper'


feature %q{
  As a user
  I want to be able to RSVP
  So organizers can see how many people go
} do

  background do
    @lesson = FactoryGirl.create(:lesson)
    @user = FactoryGirl.create(:user, school: @lesson.venue.school)
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
    @lesson = FactoryGirl.create(:lesson)
    @user = FactoryGirl.create(:user, school: @lesson.venue.school)
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
  I can't RSVP the day after the lesson
  So the attendance list is fixed
} do

  background do
    @lesson = FactoryGirl.create(:lesson, start_time: 1.day.ago, end_time: 1.day.ago+2.hours)
    @user = FactoryGirl.create(:user, school: @lesson.venue.school)
    sign_in_manually @user
  end


  scenario "RSVP no button present" do
    page.should_not have_link "RSVP!"
  end
end

feature %q{
  As a user
  I can log in and RSVP at the same time
  So my life is easy
} do

  background do
    @lesson = FactoryGirl.create(:lesson)
    @user = FactoryGirl.create(:user, school: @lesson.venue.school)
    visit "/"
  end

  scenario "try to RSVP while not logged in", :js => true do
    page.find(".announce").click_link "RSVP!"
    page.should_not have_css(".pressed")
    Attendance.all.count.should == 0
    page.should have_css("#LoginModal")
    within first('#LoginModal') do
      fill_in "user[email]", with: @user.email
      fill_in "user[password]", with: "draft1"
      find_button("Sign in").trigger(:click)
    end
    page.should have_content("Signed in successfully.")
    Attendance.all.count.should == 1
    page.should have_css(".pressed")
  end
end


feature %q{
  As a website
  I want to make sure,
  That when lesson is saved
  Slug is generated
} do

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
  That when a lesson with a google plus events hangout url but no
    archive url is saved
  The archive url is set to the google plus events hangout url
} do
  background do
    @lesson = FactoryGirl.build(:lesson)
  end

  scenario "creating a lesson with a google plus events url", js: true do
    @lesson.hangout_url = "https://plus.google.com/events/foo"
    @lesson.archive_url.should == nil
    @lesson.save!
    lessons = Lesson.all
    lessons.count.should == 1
    lessons.first.archive_url.should == "https://plus.google.com/events/foo"
  end

  scenario "creating a lesson with a google plus hoaevent url", js: true do
    @lesson.hangout_url = "https://plus.google.com/hangouts/_/hoaevent/foo"
    @lesson.archive_url.should == nil
    @lesson.save!
    lessons = Lesson.all
    lessons.count.should == 1
    lessons.first.archive_url.should == nil
  end

  scenario "creating a lesson with a non-google plus url", js: true do
    @lesson.hangout_url = "https://talkgadget.com/events/foo"
    @lesson.archive_url.should == nil
    @lesson.save!
    lessons = Lesson.all
    lessons.count.should == 1
    lessons.first.archive_url.should == nil
  end
end

feature %q{
  As a website
  I want to make sure,
  That the admin can create lessons
  So the admin can create lessons
} do

  background do
    # Pacific params
    @school_pacific = create(:school, timezone: "Pacific Time (US & Canada)")
    @venue_pacific = create(:venue, school: @school_pacific)
    @admin_pacific = create(:admin, school: @school_pacific, hide_last_name: false)
    # Eastern params
    @school_eastern = create(:school, timezone: "Eastern Time (US & Canada)")
    @venue_eastern = create(:venue, school: @school_eastern)
    @admin_eastern = create(:admin, school: @school_eastern)
  end

  scenario "creating a new upcoming lesson", :js => true do
    sign_in_manually @admin_pacific
    select_school_in_dropdown(@admin_pacific.school.name)
    create_lesson_manually("some random topic", @admin_pacific.school.venues.first)

    page.should have_content "Lesson was successfully created."
    lessons = Lesson.all
    lessons.count.should == 1

    visit "/"
    page.should have_content "some random topic"
    page.should have_content "some random summary"
    within "div.details" do
      page.should have_content "6:30pm Pacific - 8:15pm Pacific"
    end

    visit lesson_path(Lesson.last)
    within "ul.teachers" do
      page.should have_content @admin_pacific.name
    end
    within "div.details" do
      page.should have_content "6:30pm Pacific - 8:15pm Pacific"
    end
  end

  scenario "creating a new upcoming lesson from a different school timezone", :js => true do
    sign_in_manually @admin_eastern
    select_school_in_dropdown(@admin_eastern.school.name)
    create_lesson_manually("some other random topic", @admin_eastern.school.venues.first)

    visit "/?school=#{@admin_eastern.school.slug}"
    page.should have_content "some other random topic"
    within "div.details" do
      page.should have_content "6:30pm Eastern - 8:15pm Eastern"
    end

    visit lesson_path(Lesson.last)
    within "div.details" do
      page.should have_content "6:30pm Eastern - 8:15pm Eastern"
    end
  end

end

feature %q{
  As an admin
  I want to edit lessons,
  So that I can make them perfect
} do

  let(:admin) { create(:admin) }
  let(:lesson) { create(:lesson, teacher: admin) }
  let!(:venue) { create(:venue) }

  scenario "The date field is correctly populated when editing" do
    sign_in_manually(admin)
    visit edit_lesson_path(lesson)
    # field should contain date formatted like 2014-08-07
    find_field("Date").value.should eq(lesson.start_time.to_date.iso8601)
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
    @admin = FactoryGirl.create(:admin,
                                subscribe_lesson_notifications: false)
    @lesson = FactoryGirl.create(:lesson)
    @user.school = @lesson.venue.school; @user.save!
    LessonTweeter.should_receive(:new).with(@lesson, @admin).and_call_original
    stub_lesson_tweeter
    sign_in_manually @admin
  end

  scenario "Admin notifies users without setting tweet message" do
    @lesson.reload.notification_sent_at.should be_nil
    visit lesson_path(@lesson)
    NotificationMailer.should_receive(:lesson_notification).with(@lesson.id, @user.id, @admin.id)
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
    page.should_not have_content(Date.current.strftime("%B").upcase)
    page.should have_content((Date.current+1.month).strftime("%B").upcase)
  end


end

feature %q{
  As a user
  I see a calendar for the next month
  If there are no more lessons in this month
  And there is only one lesson on the 31st of the next month
} do
  background do
    Timecop.travel(Time.local(2015, 4, 30, 12))
    @user = FactoryGirl.create(:user)
    @lesson = FactoryGirl.create(:lesson,
                                 start_time: Time.local(2015, 5, 31, 10),
                                 end_time: Time.local(2015, 5, 31, 12))
    @user.school = @lesson.venue.school
    sign_in_manually @user
  end

  scenario "RSVP clicking RSVP button", js: true do
    page.should_not have_content(Date.current.strftime("%B").upcase)
    page.should have_content((Date.current + 1.month).strftime("%B").upcase)
    Timecop.return
  end
end

feature %q{
  As a visitor
  I see the right school in the page's title
  If I access a lesson directly by its URL
} do

  background do
    other_school = FactoryGirl.create(:school)
    @venue = FactoryGirl.create(:venue)
    @lesson = FactoryGirl.create(:next_month_lesson, venue: @venue)
  end


  scenario "Visiting the page directly by its URL" do
    visit lesson_path(@lesson)
    page.title.should have_content(@venue.school.name)
  end

end

feature %q{
  As a visitor
  I want to see a codewars assignment on lesson page
  if a lesson has a codewars assignment
} do

  background do
    @lesson = FactoryGirl.create(:next_month_lesson, codewars_challenge_slug: "multiply", codewars_challenge_language: "ruby")
  end

  scenario "Visiting the page directly by its URL" do
    visit lesson_path(@lesson)
    page.should have_content("Be sure to complete the following Codewars " \
      "challenge before class! (If your RailsSchool profile includes your " \
      "Codewars username, you'll get a nifty star if you complete the " \
      "challenge.) http://www.codewars.com/kata/multiply/train/ruby")
  end

end

feature %q{
  As a visitor
  I don't want to see a codewars assignment on lesson page
  if a lesson does not have a codewars assignment
} do

  background do
    @lesson = FactoryGirl.create(:next_month_lesson)
  end

  scenario "Visiting the page directly by its URL" do
    visit lesson_path(@lesson)
    page.should_not have_content("Be sure to complete the following codewars " \
      "challenge before class! (If your RailsSchool profile includes your " \
      "codewars username, you'll get a nifty star if complete the " \
      "challenge.) http://www.codewars.com/kata/multiply/train/ruby")
  end

end

feature %q{
  As a visitor
  I want to see a message about no hangout
  if a lesson has no hangout after it's notification is sent and before
    five minutes to the end of the lesson
} do
  background do
    @lesson = FactoryGirl.create(:lesson, end_time: Time.now + 1.day + 2.hours,
      notification_sent_at: Time.now - 1.day)
  end

  scenario "Visiting the page directly by its URL" do
    visit lesson_path(@lesson)
    page.should have_content("No Hangout for this lesson")
  end
end

feature %q{
  As a visitor
  I don't want to see a message about no hangout
  if a lesson has no hangout before it's notification is sent
} do
  background do
    @lesson = FactoryGirl.create(:lesson, end_time: Time.now + 1.day + 2.hours)
  end

  scenario "Visiting the page directly by its URL" do
    visit lesson_path(@lesson)
    page.should_not have_content("No Hangout for this lesson")
  end
end

feature %q{
  As a visitor
  I don't want to see a message about no hangout
  if a lesson has no hangout after it's notification is sent and after
    five minutes after the end of the lesson
} do
  background do
    @lesson = FactoryGirl.create(:lesson,
                                 start_time: Time.now - 2.hours - 6.minutes,
                                 end_time: Time.now - 6.minutes,
                                 notification_sent_at: Time.now - 1.day)
  end

  scenario "Visiting the page directly by its URL" do
    visit lesson_path(@lesson)
    page.should_not have_content("No Hangout for this lesson")
  end
end

feature %q{
  As a teacher
  who has created a lesson with a codewars assignment
  I want to see stars next to students
  who have completed it
} do

  background do
    @teacher = FactoryGirl.create(:user, teacher: true)
    @lesson = FactoryGirl.create(:lesson, codewars_challenge_slug: "multiply", codewars_challenge_language: "ruby", teacher_id: @teacher.id)
    @student = FactoryGirl.create(:user, school: @lesson.venue.school)
    create(:codewar, user_id: @student.id, slug: "multiply", language: "ruby")
    attendance = FactoryGirl.create(:attendance, lesson: @lesson, user: @student)
    sign_in_manually(@teacher)
  end

  scenario "Visiting the page directly by its URL" do
    visit lesson_path(@lesson)
    page.should have_content("★")
  end

end

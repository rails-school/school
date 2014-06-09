require 'spec_helper'

feature %q{
  As a user
  I want to be sure
  That notifications will get delivered
} do

  background do
    @user = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
    @venue = FactoryGirl.create(:venue)
    @lesson = FactoryGirl.create(:next_month_lesson)
  end

  scenario "Sending notification mail" do
    expect{NotificationMailer.lesson_notification(
      @lesson.id, @user.id, @user2.id
    ).deliver}.to change{ActionMailer::Base.deliveries.count}.by(1)    
    email = ActionMailer::Base.deliveries.last
    email.attachments.count.should == 1
    email.attachments.first.body.include?(Rails.application.routes.default_url_options[:host]).should == true
  end
end

feature %q{
  As a user
  I want to be sure
  That notifications will get delivered
} do

  background do
    @venue = FactoryGirl.create(:venue)
    @teacher = FactoryGirl.create(:admin, school: @venue.school)
    @attendee = FactoryGirl.create(:user)
    @lesson = FactoryGirl.create(:next_month_lesson, teacher_id: @teacher.id, venue_id: @venue.id)
    @attendee.rsvp_for(@lesson)
  end



  scenario "Teacher sending mail to students attending a lesson" do
    sign_in_manually @teacher
    visit lesson_path(@lesson)
    click_link "Send message to the attendees"
    fill_in "notification_subject", with: "Bring some food!"
    fill_in "notification_message", with: "Hi! We would like you to know that you need to bring some food for the teacher and Stewie!!"
    expect{click_button "Save"}.to change{ActionMailer::Base.deliveries.count}.by(1)
    page.should have_content("Notification was sent")
  end

  scenario "Not a teacher can't send notifications" do
    sign_in_manually @attendee
    visit new_lesson_notification_path(@lesson)
    page.status_code.should == 403
  end

  scenario "Not a teacher can't see the link to send message to attendees" do
    sign_in_manually @attendee
    visit lesson_path(@lesson)
    page.should_not have_content "Send message to the attendees"
  end  
end
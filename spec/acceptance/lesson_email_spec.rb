require 'spec_helper'

feature %q{
  As a user
  I want to be sure
  That notifications will get delivered
} do

  background do
    @teacher = FactoryGirl.create(:user)
    @attendee = FactoryGirl.create(:user)
    @venue = FactoryGirl.create(:venue)
    @lesson = create(
      :next_month_lesson, start_time: Date.current + 1.month + 19.hours
    )
  end

  scenario "Sending notification email" do
    expect {
      NotificationMailer.lesson_notification(
        @lesson.id, @teacher.id, @attendee.id
      ).deliver_now
    }.to change{ ActionMailer::Base.deliveries.count }.by(1)
    email = ActionMailer::Base.deliveries.last
    email.attachments.count.should == 1
    email.attachments.first.body.include?(Rails.application.routes.default_url_options[:host]).should == true
  end
end

feature %q{
  As a teacher
  I want to be sure
  That notifications contain the correct start time and timezone
} do

  background do
    # Pacific params
    @school_pacific = create(:school, timezone: "Pacific Time (US & Canada)")
    @venue_pacific = create(:venue, school: @school_pacific)
    @admin_pacific = create(:admin, school: @school_pacific)
    # Eastern params
    @school_eastern = create(:school, timezone: "Eastern Time (US & Canada)")
    @venue_eastern = create(:venue, school: @school_eastern)
    @admin_eastern = create(:admin, school: @school_eastern)
    @attendee = FactoryGirl.create(:user)
  end

  scenario "Pacific teacher sending notification email" do
    expect{create_lesson_and_send_notification(@admin_pacific, @attendee)}.to change{ActionMailer::Base.deliveries.count}.by(1)
    email = ActionMailer::Base.deliveries.last
    email.body.encoded.should include("6:30pm Pacific")
  end

  scenario "Eastern teacher sending notification email" do
    expect{create_lesson_and_send_notification(@admin_eastern, @attendee)}.to change{ActionMailer::Base.deliveries.count}.by(1)
    email = ActionMailer::Base.deliveries.last
    email.body.encoded.should include("6:30pm Eastern")
  end
end

feature %q{
  As a teacher
  I want to be sure
  That notifications contain the correct start time and timezone in calendar.ics
} do
  background do
    # Pacific params
    @school_pacific = create(:school, timezone: "Pacific Time (US & Canada)")
    @venue_pacific = create(:venue, school: @school_pacific)
    @admin_pacific = create(:admin, school: @school_pacific)
    # Eastern params
    @school_eastern = create(:school, timezone: "Eastern Time (US & Canada)")
    @venue_eastern = create(:venue, school: @school_eastern)
    @admin_eastern = create(:admin, school: @school_eastern)
    @attendee = FactoryGirl.create(:user)
  end

  scenario "Pacific teacher sending notification email" do
    expect {
      create_lesson_and_send_notification(@admin_pacific, @attendee)
    }.to change { ActionMailer::Base.deliveries.count }.by(1)
    email = ActionMailer::Base.deliveries.last
    lines = email.attachments.first.body.decoded.split("\n")
    expect(lines).to include(
      "TZID:" + ActiveSupport::TimeZone[
        @school_pacific.timezone].tzinfo.canonical_identifier
      )
    start_time = Icalendar.parse(
      email.attachments.first, true).events.first.dtstart.value
    expect(start_time).to eq (
      (Date.current + 1.day + 18.hours + 30.minutes).strftime(
        "%Y-%m-%d %H:%M:%S UTC")).to_s
  end

  scenario "Eastern teacher sending notification email" do
    expect {
      create_lesson_and_send_notification(@admin_eastern, @attendee)
    }.to change { ActionMailer::Base.deliveries.count }.by(1)
    email = ActionMailer::Base.deliveries.last
    lines = email.attachments.first.body.decoded.split("\n")
    expect(lines).to include(
      "TZID:" + ActiveSupport::TimeZone[
        @school_eastern.timezone].tzinfo.canonical_identifier
      )
    start_time = Icalendar.parse(
      email.attachments.first, true).events.first.dtstart.value
    expect(start_time).to eq (
      (Date.current + 1.day + 18.hours + 30.minutes).strftime(
        "%Y-%m-%d %H:%M:%S UTC")).to_s
  end
end

feature %q{
  As a user
  I want to be sure
  That messages about a lesson will get delivered
} do

  background do
    @venue = FactoryGirl.create(:venue)
    @teacher = FactoryGirl.create(:admin, school: @venue.school)
    @attendee = FactoryGirl.create(:user)
    @lesson = FactoryGirl.create(:next_month_lesson, teacher_id: @teacher.id, venue_id: @venue.id)
    @attendee.rsvp_for(@lesson)
  end



  scenario "Teacher sending email to students attending a lesson" do
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

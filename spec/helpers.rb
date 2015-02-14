module Helpers
  def sign_in_manually(user)
    visit new_user_session_path
    page.should have_selector('#new_user')
    within first('#new_user') do
      fill_in "user[email]", :with => user.email
      fill_in "user[password]", :with => "draft1"
      click_button "Sign in"
    end
    page.should have_content("Logout #{user.name}")
  end

  def stub_current_school
    ApplicationController.any_instance.stub(:current_school) {
      OpenStruct.new(name: "MIT")
    }
  end

  def stub_lesson_tweeter
    LessonTweeter.any_instance.stub(:tweet) { true }
  end

  def create_lesson_manually(title, venue, start_time="6:30pm", end_time="8:15pm")
    visit new_lesson_path
    page.should have_content "New lesson"
    fill_in "lesson[title]", :with => title
    fill_in "lesson[summary]", :with => "some random summary"
    fill_in "lesson[description]", :with => "some random description"
    fill_in "lesson[start_time]", :with => start_time
    fill_in "lesson[end_time]", :with => end_time
    fill_in "lesson[date]", :with => (Date.current + 1.day).to_s
    select venue.name, :from => 'Venue'
    click_button "Save"
  end

  def create_lesson_and_send_notification(teacher, attendee)
    sign_in_manually teacher
    select_school_in_dropdown(teacher.school.name)
    create_lesson_manually("some random topic", teacher.school.venues.first)
    lesson = Lesson.last
    NotificationMailer.lesson_notification(
      lesson.id, teacher.id, attendee.id
    ).deliver_now
  end

  def select_school_in_dropdown(name)
    find('li#school_dropdown').click
    within "li#school_dropdown" do
      click_link(name)
    end
  end
end

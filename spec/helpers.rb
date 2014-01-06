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
end

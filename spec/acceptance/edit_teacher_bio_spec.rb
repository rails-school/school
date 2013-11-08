require 'spec_helper'


feature %q{
  As a teacher
  I want to be able to edit my bio
  So I can tell the world something about me
} do

  background do
    @admin = FactoryGirl.create(:admin)
    sign_in_manually @admin
  end

  scenario "edit my bio", :js => true do
    visit about_path
    selector = "*[data-tag='about mike'][contenteditable]"
    page.should have_css(selector)
    page.execute_script(%Q{$("#{selector}").text("Mike is a superhero")})
    page.execute_script("$('.contenteditable_save_button').show();")
    find(".contenteditable_save_button").click
    within(selector) { page.should have_content "Mike is a superhero" }
    visit about_path
    within(selector) { page.should have_content "Mike is a superhero" }
  end

end

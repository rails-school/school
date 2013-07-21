module Helpers
  def sign_in_manually(user)
    visit new_user_session_path
    fill_in "user[email]", :with => user.email
    fill_in "user[password]", :with => "draft1"
    click_button "Sign in"
  end
end

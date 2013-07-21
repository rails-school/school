require 'spec_helper'

feature %q{
  As a student
  I want the number of lessons I've attended shown in my profile
  So I am encouraged to attend more lessons
} do

  background do
    sign_in_manually(create(:user))
  end

  scenario "Browse other user's profile" do
    other_user = create(:user, homepage: "silly.example.com")
    missed_rsvp = create(:attendance, user: other_user)
    confirmed_rsvps = 2.times.map { 
      create(:attendance, user: other_user, confirmed: true)
    }
    Timecop.travel(3.days)
    visit user_path(other_user)
    page.should have_content "attended 2 lessons"
    page.should have_link "silly.example.com"
    Timecop.return
  end
end

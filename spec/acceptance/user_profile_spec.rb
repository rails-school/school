require 'spec_helper'

feature %q{
  As a student
  I want the number of lessons I've attended shown in my profile
  So I am encouraged to attend more lessons
} do

  let(:myself) { create(:user, github_username: "example") }

  background do
    venue = create(:venue)
    sign_in_manually(myself)
  end

  scenario "Browse other user's profile" do
    other_user = create(:user, homepage: "silly.example.com")
    missed_rsvp = create(:attendance, user: other_user)
    confirmed_rsvps = 2.times.map {
      create(:attendance, user: other_user, confirmed: true)
    }
    other_user.user_badges.create(badge_id: Badge.first.id)
    Timecop.travel(3.days)
    visit user_path(other_user)
    page.should have_content "attended 2 lessons"
    page.should have_content Badge.first.new.display_name
    page.should have_link "silly.example.com"
    page.should_not have_link "github.com/example"
    Timecop.return
  end

  scenario "Browse my own profile" do
    confirmed_rsvps = 2.times.map {
      create(:attendance, user: myself, confirmed: true)
    }
    Timecop.travel(3.days)
    visit user_path(myself)
    page.should have_content "attended 2 lessons"
    page.should have_link "github.com/example"
    page.all("a[href*='github.com/example']").count.should == 1
    page.should have_css("iframe[src='//githubbadge.appspot.com/#{myself.github_username}']")
    myself.attendances.each do |attendance|
      # for some reason `have_link` doesn't find the links :/
      page.all("a[href='#{lesson_path(attendance.lesson)}']").count.should == 1
    end
    click_link "Logout"
    visit user_path(myself)
    page.all("a[href*='github.com/example']").count.should == 0
    page.should have_css("iframe[src='//githubbadge.appspot.com/#{myself.github_username}']")
    Timecop.return
  end
end

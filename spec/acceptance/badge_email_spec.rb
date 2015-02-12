require 'spec_helper'

feature %q{
  As a user
  I want to be notified of new badges
  So I can feel proud
} do
  let(:badge) { Badge.find_by_slug("49er") }
  let(:user) { create(:user) }

  scenario "Send new badge notification email" do
    expect {
      BadgeMailer.new_badge_notification(
        badge.id, user.id
      ).deliver_now
    }.to change { ActionMailer::Base.deliveries.count }.by(1)
    email = ActionMailer::Base.deliveries.last
    email.parts.length.should == 2
    email.parts.each do |part|
      part.body.should include("49er")
      part.body.should include("You have been awarded a new badge")
    end
  end
end

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

  scenario "Sending notification mail", :js => true do

    expect{NotificationMailer.lesson_notification(
      @lesson.id, @user.id, @user2.id
    ).deliver}.to change{ActionMailer::Base.deliveries.count}.by(1)    
    email = ActionMailer::Base.deliveries.last
    email.attachments.count.should == 1
    email.attachments.first.body.include?(Rails.application.routes.default_url_options[:host]).should == true
  end
end
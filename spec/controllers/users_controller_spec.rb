require 'spec_helper'
require 'ostruct'

describe UsersController do
  describe "POST /bounce_reports" do
    let!(:user) { FactoryGirl.create(:user) }

    before(:each) do
      ApplicationController.any_instance.stub(:current_school).and_return(
        # Let's create an anonymous object responding to
        # methods timezone and slug
        # so the before_filter set_time_zone works always
        OpenStruct.new(
          timezone: "Pacific Time (US & Canada)",
          slug: "pretty-cool-completely-virtual-lesson"
        )
      )

      # Create a token for the controller to check
      ENV.stub(:[]).with("SENDGRID_EVENT_TOKEN").and_return("my_token")
    end

    it "marks the associated user as unsubscribed" do
      get "report_email_bounce", token: "my_token", email: user.email,
                                 event: "bounce"
      response.status.should be(200)
      expect(user.reload).not_to be_subscribe_lesson_notifications
    end

    it "fails when no event param is passed" do
      get "report_email_bounce", token: "my_token", email: user.email
      response.status.should be(422)
      expect(user.reload).to be_subscribe_lesson_notifications
    end

    it "fails when no email is passed" do
      get "report_email_bounce", token: "my_token", event: "bounce"
      response.status.should be(422)
      expect(user.reload).to be_subscribe_lesson_notifications
    end

    it "fails for events other than bounce is passed" do
      get "report_email_bounce", token: "my_token", email: user.email,
                                 event: "open"
      response.status.should be(422)
      expect(user.reload).to be_subscribe_lesson_notifications
    end

    it "fails when no credentials" do
      get "report_email_bounce", email: user.email, event: "bounce"
      response.status.should be(401)
      expect(user.reload).to be_subscribe_lesson_notifications
    end

    it "fails when bad credentials" do
      get "report_email_bounce", token: "foo", email: user.email,
                                 event: "bounce"
      response.status.should be(401)
      expect(user.reload).to be_subscribe_lesson_notifications
    end
  end
end

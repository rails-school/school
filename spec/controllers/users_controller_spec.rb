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
      get "report_email_bounce", token: "my_token",
                                 _json: sendgrid_payload(user.email, "bounce")
      response.status.should be(200)
      expect(user.reload).not_to be_subscribe_lesson_notifications
    end

    it "does not update the user record for events other than bounce" do
      get "report_email_bounce", token: "my_token",
                                 _json: sendgrid_payload(user.email, "open")
      response.status.should be(200)
      expect(user.reload).to be_subscribe_lesson_notifications
    end

    it "fails when no credentials" do
      get "report_email_bounce", _json: sendgrid_payload(user.email, "bounce")
      response.status.should be(401)
      expect(user.reload).to be_subscribe_lesson_notifications
    end

    it "fails when bad credentials" do
      get "report_email_bounce", token: "foo",
                                 _json: sendgrid_payload(user.email, "bounce")
      response.status.should be(401)
      expect(user.reload).to be_subscribe_lesson_notifications
    end

    def sendgrid_payload(email, event)
      [{ email: email, event: event }]
    end
  end
end

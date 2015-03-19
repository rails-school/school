require 'spec_helper'
require 'ostruct'

describe UsersController do
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
  end

  describe "POST /bounce_reports" do
    let!(:user) { FactoryGirl.create(:user) }

    before(:each) do
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

  describe "POST /:id/notify_subscribers" do
    let!(:lesson) {
      create(:lesson, teacher: create(:user, teacher: true))
    }
    let!(:previous_lesson) {
      create(:lesson, start_time: lesson.start_time - 1.week,
             end_time: lesson.end_time - 1.week,
             venue: lesson.venue)
    }
    before do
      controller.stub(:current_user).and_return(lesson.teacher)
    end

    context "The previous lesson is over" do
      around do |example|
        Timecop.freeze(previous_lesson.end_time + 1.minute) do
          example.run
        end
      end

      it "notifies the subscribers of the new lesson" do
        expect(LessonTweeter).to receive(:new).exactly(:once)
          .and_call_original
        post :notify_subscribers, id: lesson.id
        expect(response).to redirect_to(lesson_path(lesson))
        expect(flash[:notice]).to include("Subscribers notified")
        expect(lesson.reload.notification_sent_at).to eq(Time.now)
      end
    end

    context "The previous lesson is not over" do
      around do |example|
        Timecop.freeze(previous_lesson.end_time - 1.minute) do
          example.run
        end
      end

      it "does NOT notify the subscribers of the new lesson" do
        expect(LessonTweeter).to receive(:new).exactly(0).times
        post :notify_subscribers, id: lesson.id
        expect(response).to redirect_to(lesson_path(lesson))
        expect(flash[:error]).to include("Please wait")
        expect(lesson.reload.notification_sent_at).to be_nil
      end
    end
  end
end

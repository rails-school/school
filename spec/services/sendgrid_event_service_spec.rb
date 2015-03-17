require "spec_helper"

describe SendgridEventService do
  let(:webhook_payload) do
    JSON.parse(
      File.open("spec/support/request_stubs/sendgrid_webhook.json", "rb").read
    ).with_indifferent_access
  end

  context "when an email bounces" do
    let!(:bounced_user) { create(:user, email: "bouncedemail@example.com") }
    before { SendgridEventService.new(request_params: webhook_payload).perform }

    it "should unsubscribe the user" do
      expect(bounced_user.reload.subscribe_lesson_notifications).to be_falsey
      expect(bounced_user.subscribe_badge_notifications).to be_falsey
    end
  end

  context "when a user marks our email as spam" do
    let!(:spam_user) { create(:user, email: "spamemail@example.com") }
    before { SendgridEventService.new(request_params: webhook_payload).perform }

    it "should unsubscribe the user" do
      expect(spam_user.reload.subscribe_lesson_notifications).to be_falsey
      expect(spam_user.subscribe_badge_notifications).to be_falsey
    end
  end

  context "when one of our mailing list emails is marked as spam" do
    let!(:list_user) {
      create(:user, email: "listemail@example.com",
                    password: nil,
                    password_confirmation: nil)
    }

    before do
      SendgridEventService.new(request_params: webhook_payload).perform
    end

    it "should not unsubscribe the user" do
      expect(list_user.reload.subscribe_lesson_notifications).to be_truthy
      expect(list_user.subscribe_badge_notifications).to be_truthy
    end
  end
end

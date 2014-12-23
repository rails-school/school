require 'spec_helper'

describe User do
  describe "#generate_unsubscribe_token" do
    subject { create(:user) }

    context "user already has unsubscribe token" do
      it "doesn't change the existing token" do
        existing_token = subject.unsubscribe_token
        expect(existing_token).to be_present

        subject.generate_unsubscribe_token
        expect(existing_token).to eq(subject.unsubscribe_token)
      end
    end
  end
end

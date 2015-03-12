require "spec_helper"

describe Badge::BobaFett do
  describe ".allocate_to_user?" do
    let(:user) { create(:user) }

    subject { Badge::BobaFett.allocate_to_user?(user) }

    context "user did not attend any classes" do
      it { should eq(false) }
    end

    context "user rsvp'd but did not attend classes" do
      before { 35.times { create(:attendance, confirmed: false, user: user) } }
      it { should eq(false) }
    end

    context "user attended less than 35 classes" do
      before { 34.times { create(:attendance, confirmed: true, user: user) } }
      it { should eq(false) }
    end

    context "user attended exactly 35 classes" do
      before { 35.times { create(:attendance, confirmed: true, user: user) } }
      it { should eq(true) }
    end

    context "user attended more than 35" do
      before { 36.times { create(:attendance, confirmed: true, user: user) } }
      it { should eq(true) }
    end
  end
end

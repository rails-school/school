require "spec_helper"

describe Badge::Greedo do
  describe ".allocate_to_user?" do
    let(:user) { create(:user) }

    subject { Badge::Greedo.allocate_to_user?(user) }

    context "user did not attend any classes" do
      it { should eq(false) }
    end

    context "user rsvp'd but did not attend classes" do
      before { 15.times { create(:attendance, confirmed: false, user: user) } }
      it { should eq(false) }
    end

    context "user attended less than 15 classes" do
      before { 14.times { create(:attendance, confirmed: true, user: user) } }
      it { should eq(false) }
    end

    context "user attended exactly 15 classes" do
      before { 15.times { create(:attendance, confirmed: true, user: user) } }
      it { should eq(true) }
    end

    context "user attended more than 15 classes" do
      before { 16.times { create(:attendance, confirmed: true, user: user) } }
      it { should eq(true) }
    end
  end
end

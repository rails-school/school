require "spec_helper"

describe Badge::HanSolo do
  describe ".allocate_to_user?" do
    let(:user) { create(:user) }

    subject { Badge::HanSolo.allocate_to_user?(user) }

    context "user did not attend any classes" do
      it { should eq(false) }
    end

    context "user rsvp'd but did not attend classes" do
      before { 100.times { create(:attendance, confirmed: false, user: user) } }
      it { should eq(false) }
    end

    context "user attended less than 100 classes" do
      before { 99.times { create(:attendance, confirmed: true, user: user) } }
      it { should eq(false) }
    end

    context "user attended exactly 100 classes" do
      before { 100.times { create(:attendance, confirmed: true, user: user) } }
      it { should eq(true) }
    end

    context "user attended more than 100 classes" do
      before { 101.times { create(:attendance, confirmed: true, user: user) } }
      it { should eq(true) }
    end
  end
end

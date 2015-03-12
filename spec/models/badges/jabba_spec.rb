require "spec_helper"

describe Badge::Jabba do
  describe ".allocate_to_user?" do
    let(:user) { create(:user) }

    subject { Badge::Jabba.allocate_to_user?(user) }

    context "user did not attend any classes" do
      it { should eq(false) }
    end

    context "user rsvp'd but did not attend classes" do
      before { 50.times { create(:attendance, confirmed: false, user: user) } }
      it { should eq(false) }
    end

    context "user attended less than 50 classes" do
      before { 49.times { create(:attendance, confirmed: true, user: user) } }
      it { should eq(false) }
    end

    context "user attended exactly 50 classes" do
      before { 50.times { create(:attendance, confirmed: true, user: user) } }
      it { should eq(true) }
    end

    context "user attended more than 50 classes" do
      before { 51.times { create(:attendance, confirmed: true, user: user) } }
      it { should eq(true) }
    end
  end
end

require "spec_helper"

describe Badge::Ewok do

  describe ".allocate_to_user?" do
    let(:user) { create(:user) }

    subject { Badge::Ewok.allocate_to_user?(user) }

    context "user did not attend any classes" do
      it { should eq(false) }
    end

    context "user rsvp'd but did not attend classes" do
      before { 5.times { create(:attendance, confirmed: false, user: user) } }
      it { should eq(false) }
    end

    context "user attended less than 5 classes" do
      before { 4.times { create(:attendance, confirmed: true, user: user) } }
      it { should eq(false) }
    end

    context "user attended exactly 5 classes" do
      before { 5.times { create(:attendance, confirmed: true, user: user) } }
      it { should eq(true) }
    end

    context "user attended more than 5 classes" do
      before { 6.times { create(:attendance, confirmed: true, user: user) } }
      it { should eq(true) }
    end
  end
end

require "spec_helper"

describe Badge::BridgeTroll do
  describe ".allocate_to_user?" do
    subject { Badge::BridgeTroll.allocate_to_user?(user) }

    context "user did not attend any RailsBridge classes" do
      let(:user) { create(:user) }
      it { should eq(false) }
    end

    context "user attended more than one RailsBridge class" do
      let(:user) { create(:user, rails_bridge_class_count: 1) }
      it { should eq(true) }
    end
  end
end

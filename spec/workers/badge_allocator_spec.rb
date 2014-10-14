require 'spec_helper'

describe BadgeAllocator do
  describe ".perform_async" do
    let(:user) { create(:user) }
    around do |example|
      real_including_classes = Badge.instance_variable_get("@including_classes")
      Badge.instance_variable_set("@including_classes", [Badge::FortyNiner])
      example.run
      Badge.instance_variable_set("@including_classes", real_including_classes)
    end

    context "the user is eligible" do
      context "but already has the badge" do
        let!(:user_badge) {
          UserBadge.create(badge_id: Badge::FortyNiner.id, user_id: user.id)
        }

        it "doesn't check if the user should get the badge" do
          Badge::FortyNiner.should_not_receive(:allocate_to_user?)
          BadgeAllocator.perform_async(user.id)
          UserBadge.count.should == 1
        end
      end

      context "and doesn't have the badge yet" do
        it "checks if the user should get the badge and creates badge" do
          UserBadge.count.should == 0
          Badge::FortyNiner.should_receive(:allocate_to_user?).and_return(true)
          BadgeAllocator.perform_async(user.id)
          user.reload.badges.map(&:slug).should == ["49er"]
        end

      end
    end

    context "the user ineligible (and doesn't have the badge)" do
      it "checks if the user should get the badge but does not create badge" do
        Badge::FortyNiner.should_receive(:allocate_to_user?).and_return(false)
        BadgeAllocator.perform_async(user.id)
        UserBadge.count.should == 0
      end
    end
  end
end

require "spec_helper"

describe BridgeTrollRecorder do
  describe ".perform_async" do
    let!(:user) { create(:user) }
    let!(:bt_user) { create(:user, bridge_troll_user_id: "1") }

    before { BridgeTrollRecorder.perform_async }

    context "when updating RailsBridge class counts" do
      it "should not update users without a bridge troll id" do
        expect(user.reload.rails_bridge_class_count).to eq 0
      end

      it "should update users with a bridge troll id" do
        expect(bt_user.reload.rails_bridge_class_count).to eq 15
      end
    end
  end
end

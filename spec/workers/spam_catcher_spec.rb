require "spec_helper"

describe SpamCatcher do
  describe ".perform_async" do
    context "fixing a spam report" do
      let(:result) { SpamCatcher.perform_async }
      it "should return true" do
        expect(result).to be_truthy
      end
    end
  end
end

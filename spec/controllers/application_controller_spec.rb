require 'spec_helper'

describe ApplicationController do
  def nyc_location
    mock_location = double(Geocoder::Result::Freegeoip)
    mock_location.stub(:latitude).and_return(40.67)
    mock_location.stub(:longitude).and_return(-73.94)

    mock_location
  end
  describe "current_school with geocoding on", geocode: true do

    it "defaults to school for the nearest venue" do
      school1 = create(:school)
      school2 = create(:school)

      # SF
      venue1 = create(:venue, zip: 94102, state: 'California', school: school1)

      # Charlottesville, VA
      venue2 = create(:venue, zip: 22902, state: 'Virginia', school: school2)

      request.should_receive(:location).once.and_return nyc_location
      controller.current_school.should == school2
    end

    it "can be set through a query param" do
      school1 = create(:school, slug: 'sf')
      school2 = create(:school, slug: 'oak')

      controller.params = {school: 'oak'}
      controller.current_school.should == school2

      controller.params = {}
      controller.instance_variable_set('@current_school', nil)
      controller.current_school.should == school2
    end

    it "handles bad query params gracefully" do
      school = create(:school)
      venue = create(:venue, zip: 94102, school: school)

      [nil, '', 'doesnotexist'].each do |slug|
        request.should_receive(:location).once.and_return nyc_location
        controller.params = {school: slug}
        controller.current_school.should == school
        controller.instance_variable_set('@current_school', nil)
      end
    end

    it "rescues exception during geocoding" do
      school = create(:school)
      venue = create(:venue, zip: 94102, school: school)
      request.stub(:location) { raise StandardError }
      controller.current_school.should == school
    end

    context "when current_user exists" do
      let(:school) { create(:school) }

      before do
        other_school = create(:school)
        user = create(:user, school: school)
        controller.stub(:current_user).and_return user
      end

      it "defaults to the current user's school" do
        controller.current_school.should == school
      end

      it "can be set through a query param" do
        school2 = create(:school, slug: 'oak')

        controller.params = {school: 'oak'}
        controller.current_school.should == school2

        controller.params = {}
        controller.instance_variable_set('@current_school', nil)

        controller.current_school.should == school2        
      end
    end
  end

  describe "maybe_enqueue_badge_allocator" do
    before do
      Timecop.freeze
      controller.stub(:current_user).and_return user
    end

    context "current_user has never had a badge allocation job" do
      let(:user) { create(:user, last_badges_checked_at: nil) }

      it "enqueues a badge allocation job and sets last_badges_checked_at" do
        BadgeAllocator.should_receive(:perform_async).with(user.id)
        controller.send(:maybe_enqueue_badge_allocator)
        user.reload.last_badges_checked_at.to_i.should == Time.now.to_i
      end
    end

    context "current_user has had a badge allocation job 2 hours ago" do
      let(:user) do
        create(:user, last_badges_checked_at: Time.now - 2.hours.ago)
      end

      it "enqueues a badge allocation job and sets last_badges_checked_at" do
        BadgeAllocator.should_receive(:perform_async).with(user.id)
        controller.send(:maybe_enqueue_badge_allocator)
        user.reload.last_badges_checked_at.to_i.should == Time.now.to_i
      end
    end

    context "current_user had a badge allocation job 5 minutes ago" do
      let(:user) do
        create(:user, last_badges_checked_at: Time.now - 5.minutes)
      end

      it "does not enqueue a badge allocation job or set"\
        " last_badges_checked_at" do
        BadgeAllocator.should_not_receive(:perform_async)
        controller.send(:maybe_enqueue_badge_allocator)
        user.reload.last_badges_checked_at.to_i.should ==
          (Time.now - 5.minutes).to_i
      end
    end

    context "current_user has never had a bridge troll recorded job" do
      let(:user) { create(:user, last_badges_checked_at: nil) }

      it "enqueues a bridge troll recorder job and sets"\
        " last_badges_checked_at" do
        BridgeTrollRecorder.should_receive(:perform_async)
        controller.send(:maybe_enqueue_badge_allocator)
        user.reload.last_badges_checked_at.to_i.should == Time.now.to_i
      end
    end

    context "current_user has had a bridge troll recorded job 2 hours ago" do
      let(:user) do
        create(:user, last_badges_checked_at: Time.now - 2.hours.ago)
      end

      it "enqueues a bridge troll recorder job and sets"\
        " last_badges_checked_at" do
        BridgeTrollRecorder.should_receive(:perform_async)
        controller.send(:maybe_enqueue_badge_allocator)
        user.reload.last_badges_checked_at.to_i.should == Time.now.to_i
      end
    end

    context "current_user had a bridge troll recorded job 5 minutes ago" do
      let(:user) do
        create(:user, last_badges_checked_at: Time.now - 5.minutes)
      end

      it "does not enqueue a bridge troll recorder job or set"\
        " last_badges_checked_at" do
        BridgeTrollRecorder.should_not_receive(:perform_async)
        controller.send(:maybe_enqueue_badge_allocator)
        user.reload.last_badges_checked_at.to_i.should ==
          (Time.now - 5.minutes).to_i
      end
    end
  end
end

require 'spec_helper'

describe ApplicationController do
  def nyc_location
    mock_location = double(Geocoder::Result::Freegeoip)
    mock_location.stub(:latitude).and_return(40.67)
    mock_location.stub(:longitude).and_return(-73.94)

    mock_location
  end
  describe "current_school" do

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
end

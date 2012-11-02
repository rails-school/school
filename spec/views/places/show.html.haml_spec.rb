require 'spec_helper'

describe "places/show" do
  before(:each) do
    @place = assign(:place, stub_model(Place,
      :address => "Address",
      :city => "City",
      :state => "State",
      :country => "Country",
      :zip => "Zip"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Address/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/Country/)
    rendered.should match(/Zip/)
  end
end

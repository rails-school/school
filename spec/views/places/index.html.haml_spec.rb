require 'spec_helper'

describe "places/index" do
  before(:each) do
    assign(:places, [
      stub_model(Place,
        :address => "Address",
        :city => "City",
        :state => "State",
        :country => "Country",
        :zip => "Zip"
      ),
      stub_model(Place,
        :address => "Address",
        :city => "City",
        :state => "State",
        :country => "Country",
        :zip => "Zip"
      )
    ])
  end

  it "renders a list of places" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
  end
end

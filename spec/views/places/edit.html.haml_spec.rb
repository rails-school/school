require 'spec_helper'

describe "places/edit" do
  before(:each) do
    @place = assign(:place, stub_model(Place,
      :address => "MyString",
      :city => "MyString",
      :state => "MyString",
      :country => "MyString",
      :zip => "MyString"
    ))
  end

  it "renders the edit place form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => places_path(@place), :method => "post" do
      assert_select "input#place_address", :name => "place[address]"
      assert_select "input#place_city", :name => "place[city]"
      assert_select "input#place_state", :name => "place[state]"
      assert_select "input#place_country", :name => "place[country]"
      assert_select "input#place_zip", :name => "place[zip]"
    end
  end
end

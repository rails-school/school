require 'spec_helper'

describe "Places" do
  describe "GET /venues" do
    it "works! (now write some real specs)" do
      create(:venue)
      get venues_path
      response.status.should be(200)
    end
  end
end

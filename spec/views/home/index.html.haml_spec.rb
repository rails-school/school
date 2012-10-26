require 'spec_helper'
require 'factory_girl'




  describe "GET :index" do
    include Devise::TestHelpers



    context "signed in" do
        before(:each) do
          @user = FactoryGirl.build(:user)
          sign_in @user
        end

        it "fucking have Logout link" do
          #render
          binding.pry
          #it { should respond_with :success }
        end    

    end
    

end    

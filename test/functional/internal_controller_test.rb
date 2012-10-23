require 'test_helper'

class InternalControllerTest < ActionController::TestCase
  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get calendar" do
    get :calendar
    assert_response :success
  end

end

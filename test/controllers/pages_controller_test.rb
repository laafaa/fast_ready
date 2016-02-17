require 'test_helper'

class PagesControllerTest < ActionController::TestCase
	 test "should get home" do
     get :home
     assert_response :success
   end
 
   test "should get game" do
     get :game
     assert_response :success
   end
 
   test "should get about" do
     get :about
     assert_response :success
   end
 
   test "should get contact" do
    get :contact
   end
    
  test "should get profile" do
    get :profile
    assert_response :success
  end

end

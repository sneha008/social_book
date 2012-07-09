require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get welcome_page" do
    get :welcome_page
    assert_response :success
  end

end

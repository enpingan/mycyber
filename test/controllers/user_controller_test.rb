require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get mailer" do
    get :mailer
    assert_response :success
  end

end

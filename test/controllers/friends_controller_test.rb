require 'test_helper'

class FriendsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get friends_index_url
    assert_response :success
  end

  test "should get edit" do
    get friends_edit_url
    assert_response :success
  end

end

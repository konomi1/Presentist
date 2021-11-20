require 'test_helper'

class PresentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get presents_index_url
    assert_response :success
  end

  test "should get show" do
    get presents_show_url
    assert_response :success
  end

  test "should get new" do
    get presents_new_url
    assert_response :success
  end

  test "should get edit" do
    get presents_edit_url
    assert_response :success
  end

end

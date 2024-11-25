require "test_helper"

class User::ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_contacts_new_url
    assert_response :success
  end

  test "should get confirm" do
    get user_contacts_confirm_url
    assert_response :success
  end

  test "should get done" do
    get user_contacts_done_url
    assert_response :success
  end
end

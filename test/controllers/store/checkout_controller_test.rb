require "test_helper"

class Store::CheckoutControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get store_checkout_new_url
    assert_response :success
  end

  test "should get create" do
    get store_checkout_create_url
    assert_response :success
  end
end

require "test_helper"

class GAdminControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get g_admin_index_url
    assert_response :success
  end
end

require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get produtos" do
    get home_produtos_url
    assert_response :success
  end

  test "should get cursos" do
    get home_cursos_url
    assert_response :success
  end

  test "should get blog" do
    get home_blog_url
    assert_response :success
  end
end

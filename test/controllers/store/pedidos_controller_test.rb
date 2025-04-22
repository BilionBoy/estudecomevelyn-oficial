require "test_helper"

class Store::PedidosControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get store_pedidos_show_url
    assert_response :success
  end

  test "should get index" do
    get store_pedidos_index_url
    assert_response :success
  end
end

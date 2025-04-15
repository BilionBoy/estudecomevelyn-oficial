require "test_helper"

class IPromocaoProdutosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @i_promocao_produto = i_promocao_produtos(:one)
  end

  test "should get index" do
    get i_promocao_produtos_url
    assert_response :success
  end

  test "should get new" do
    get new_i_promocao_produto_url
    assert_response :success
  end

  test "should create i_promocao_produto" do
    assert_difference("IPromocaoProduto.count") do
      post i_promocao_produtos_url, params: { i_promocao_produto: { i_produto_id: @i_promocao_produto.i_produto_id, i_promocao_id: @i_promocao_produto.i_promocao_id, preco_promocional: @i_promocao_produto.preco_promocional } }
    end

    assert_redirected_to i_promocao_produto_url(IPromocaoProduto.last)
  end

  test "should show i_promocao_produto" do
    get i_promocao_produto_url(@i_promocao_produto)
    assert_response :success
  end

  test "should get edit" do
    get edit_i_promocao_produto_url(@i_promocao_produto)
    assert_response :success
  end

  test "should update i_promocao_produto" do
    patch i_promocao_produto_url(@i_promocao_produto), params: { i_promocao_produto: { i_produto_id: @i_promocao_produto.i_produto_id, i_promocao_id: @i_promocao_produto.i_promocao_id, preco_promocional: @i_promocao_produto.preco_promocional } }
    assert_redirected_to i_promocao_produto_url(@i_promocao_produto)
  end

  test "should destroy i_promocao_produto" do
    assert_difference("IPromocaoProduto.count", -1) do
      delete i_promocao_produto_url(@i_promocao_produto)
    end

    assert_redirected_to i_promocao_produtos_url
  end
end

require "test_helper"

class IProdutosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @i_produto = i_produtos(:one)
  end

  test "should get index" do
    get i_produtos_url
    assert_response :success
  end

  test "should get new" do
    get new_i_produto_url
    assert_response :success
  end

  test "should create i_produto" do
    assert_difference("IProduto.count") do
      post i_produtos_url, params: { i_produto: { arquivo_url: @i_produto.arquivo_url, created_by: @i_produto.created_by, deleted_at: @i_produto.deleted_at, descricao: @i_produto.descricao, g_categoria_id: @i_produto.g_categoria_id, imagem_url: @i_produto.imagem_url, nome: @i_produto.nome, preco: @i_produto.preco, slug: @i_produto.slug, status: @i_produto.status, updated_by: @i_produto.updated_by } }
    end

    assert_redirected_to i_produto_url(IProduto.last)
  end

  test "should show i_produto" do
    get i_produto_url(@i_produto)
    assert_response :success
  end

  test "should get edit" do
    get edit_i_produto_url(@i_produto)
    assert_response :success
  end

  test "should update i_produto" do
    patch i_produto_url(@i_produto), params: { i_produto: { arquivo_url: @i_produto.arquivo_url, created_by: @i_produto.created_by, deleted_at: @i_produto.deleted_at, descricao: @i_produto.descricao, g_categoria_id: @i_produto.g_categoria_id, imagem_url: @i_produto.imagem_url, nome: @i_produto.nome, preco: @i_produto.preco, slug: @i_produto.slug, status: @i_produto.status, updated_by: @i_produto.updated_by } }
    assert_redirected_to i_produto_url(@i_produto)
  end

  test "should destroy i_produto" do
    assert_difference("IProduto.count", -1) do
      delete i_produto_url(@i_produto)
    end

    assert_redirected_to i_produtos_url
  end
end

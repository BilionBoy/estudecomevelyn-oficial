require "test_helper"

class GCategoriasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_categoria = g_categorias(:one)
  end

  test "should get index" do
    get g_categorias_url
    assert_response :success
  end

  test "should get new" do
    get new_g_categoria_url
    assert_response :success
  end

  test "should create g_categoria" do
    assert_difference("GCategoria.count") do
      post g_categorias_url, params: { g_categoria: { created_at: @g_categoria.created_at, deleted_at: @g_categoria.deleted_at, descricao: @g_categoria.descricao, nome: @g_categoria.nome, segmento_id: @g_categoria.segmento_id, slug: @g_categoria.slug, updated_at: @g_categoria.updated_at } }
    end

    assert_redirected_to g_categoria_url(GCategoria.last)
  end

  test "should show g_categoria" do
    get g_categoria_url(@g_categoria)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_categoria_url(@g_categoria)
    assert_response :success
  end

  test "should update g_categoria" do
    patch g_categoria_url(@g_categoria), params: { g_categoria: { created_at: @g_categoria.created_at, deleted_at: @g_categoria.deleted_at, descricao: @g_categoria.descricao, nome: @g_categoria.nome, segmento_id: @g_categoria.segmento_id, slug: @g_categoria.slug, updated_at: @g_categoria.updated_at } }
    assert_redirected_to g_categoria_url(@g_categoria)
  end

  test "should destroy g_categoria" do
    assert_difference("GCategoria.count", -1) do
      delete g_categoria_url(@g_categoria)
    end

    assert_redirected_to g_categorias_url
  end
end

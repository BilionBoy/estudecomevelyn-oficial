require "test_helper"

class GBlogCategoriasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_blog_categoria = g_blog_categorias(:one)
  end

  test "should get index" do
    get g_blog_categorias_url
    assert_response :success
  end

  test "should get new" do
    get new_g_blog_categoria_url
    assert_response :success
  end

  test "should create g_blog_categoria" do
    assert_difference("GBlogCategoria.count") do
      post g_blog_categorias_url, params: { g_blog_categoria: { descricao: @g_blog_categoria.descricao } }
    end

    assert_redirected_to g_blog_categoria_url(GBlogCategoria.last)
  end

  test "should show g_blog_categoria" do
    get g_blog_categoria_url(@g_blog_categoria)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_blog_categoria_url(@g_blog_categoria)
    assert_response :success
  end

  test "should update g_blog_categoria" do
    patch g_blog_categoria_url(@g_blog_categoria), params: { g_blog_categoria: { descricao: @g_blog_categoria.descricao } }
    assert_redirected_to g_blog_categoria_url(@g_blog_categoria)
  end

  test "should destroy g_blog_categoria" do
    assert_difference("GBlogCategoria.count", -1) do
      delete g_blog_categoria_url(@g_blog_categoria)
    end

    assert_redirected_to g_blog_categorias_url
  end
end

require "test_helper"

class GBlogPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_blog_post = g_blog_posts(:one)
  end

  test "should get index" do
    get g_blog_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_g_blog_post_url
    assert_response :success
  end

  test "should create g_blog_post" do
    assert_difference("GBlogPost.count") do
      post g_blog_posts_url, params: { g_blog_post: { conteudo: @g_blog_post.conteudo, data_publicacao: @g_blog_post.data_publicacao, g_blog_categoria_id: @g_blog_post.g_blog_categoria_id, resumo: @g_blog_post.resumo, titulo: @g_blog_post.titulo } }
    end

    assert_redirected_to g_blog_post_url(GBlogPost.last)
  end

  test "should show g_blog_post" do
    get g_blog_post_url(@g_blog_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_blog_post_url(@g_blog_post)
    assert_response :success
  end

  test "should update g_blog_post" do
    patch g_blog_post_url(@g_blog_post), params: { g_blog_post: { conteudo: @g_blog_post.conteudo, data_publicacao: @g_blog_post.data_publicacao, g_blog_categoria_id: @g_blog_post.g_blog_categoria_id, resumo: @g_blog_post.resumo, titulo: @g_blog_post.titulo } }
    assert_redirected_to g_blog_post_url(@g_blog_post)
  end

  test "should destroy g_blog_post" do
    assert_difference("GBlogPost.count", -1) do
      delete g_blog_post_url(@g_blog_post)
    end

    assert_redirected_to g_blog_posts_url
  end
end

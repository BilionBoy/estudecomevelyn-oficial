require "application_system_test_case"

class GBlogPostsTest < ApplicationSystemTestCase
  setup do
    @g_blog_post = g_blog_posts(:one)
  end

  test "visiting the index" do
    visit g_blog_posts_url
    assert_selector "h1", text: "G blog posts"
  end

  test "should create g blog post" do
    visit g_blog_posts_url
    click_on "New g blog post"

    fill_in "Conteudo", with: @g_blog_post.conteudo
    fill_in "Data publicacao", with: @g_blog_post.data_publicacao
    fill_in "G blog categoria", with: @g_blog_post.g_blog_categoria_id
    fill_in "Resumo", with: @g_blog_post.resumo
    fill_in "Titulo", with: @g_blog_post.titulo
    click_on "Create G blog post"

    assert_text "G blog post was successfully created"
    click_on "Back"
  end

  test "should update G blog post" do
    visit g_blog_post_url(@g_blog_post)
    click_on "Edit this g blog post", match: :first

    fill_in "Conteudo", with: @g_blog_post.conteudo
    fill_in "Data publicacao", with: @g_blog_post.data_publicacao.to_s
    fill_in "G blog categoria", with: @g_blog_post.g_blog_categoria_id
    fill_in "Resumo", with: @g_blog_post.resumo
    fill_in "Titulo", with: @g_blog_post.titulo
    click_on "Update G blog post"

    assert_text "G blog post was successfully updated"
    click_on "Back"
  end

  test "should destroy G blog post" do
    visit g_blog_post_url(@g_blog_post)
    click_on "Destroy this g blog post", match: :first

    assert_text "G blog post was successfully destroyed"
  end
end

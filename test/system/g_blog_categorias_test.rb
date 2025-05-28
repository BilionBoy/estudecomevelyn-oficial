require "application_system_test_case"

class GBlogCategoriaTest < ApplicationSystemTestCase
  setup do
    @g_blog_categoria = g_blog_categorias(:one)
  end

  test "visiting the index" do
    visit g_blog_categorias_url
    assert_selector "h1", text: "G blog categoria"
  end

  test "should create g blog categoria" do
    visit g_blog_categorias_url
    click_on "New g blog categoria"

    fill_in "Descricao", with: @g_blog_categoria.descricao
    click_on "Create G blog categoria"

    assert_text "G blog categoria was successfully created"
    click_on "Back"
  end

  test "should update G blog categoria" do
    visit g_blog_categoria_url(@g_blog_categoria)
    click_on "Edit this g blog categoria", match: :first

    fill_in "Descricao", with: @g_blog_categoria.descricao
    click_on "Update G blog categoria"

    assert_text "G blog categoria was successfully updated"
    click_on "Back"
  end

  test "should destroy G blog categoria" do
    visit g_blog_categoria_url(@g_blog_categoria)
    click_on "Destroy this g blog categoria", match: :first

    assert_text "G blog categoria was successfully destroyed"
  end
end

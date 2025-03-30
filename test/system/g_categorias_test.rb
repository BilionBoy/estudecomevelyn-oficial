require "application_system_test_case"

class GCategoriasTest < ApplicationSystemTestCase
  setup do
    @g_categoria = g_categorias(:one)
  end

  test "visiting the index" do
    visit g_categorias_url
    assert_selector "h1", text: "G categorias"
  end

  test "should create g categoria" do
    visit g_categorias_url
    click_on "New g categoria"

    fill_in "Created at", with: @g_categoria.created_at
    fill_in "Deleted at", with: @g_categoria.deleted_at
    fill_in "Descricao", with: @g_categoria.descricao
    fill_in "Nome", with: @g_categoria.nome
    fill_in "Segmento", with: @g_categoria.segmento_id
    fill_in "Slug", with: @g_categoria.slug
    fill_in "Updated at", with: @g_categoria.updated_at
    click_on "Create G categoria"

    assert_text "G categoria was successfully created"
    click_on "Back"
  end

  test "should update G categoria" do
    visit g_categoria_url(@g_categoria)
    click_on "Edit this g categoria", match: :first

    fill_in "Created at", with: @g_categoria.created_at.to_s
    fill_in "Deleted at", with: @g_categoria.deleted_at.to_s
    fill_in "Descricao", with: @g_categoria.descricao
    fill_in "Nome", with: @g_categoria.nome
    fill_in "Segmento", with: @g_categoria.segmento_id
    fill_in "Slug", with: @g_categoria.slug
    fill_in "Updated at", with: @g_categoria.updated_at.to_s
    click_on "Update G categoria"

    assert_text "G categoria was successfully updated"
    click_on "Back"
  end

  test "should destroy G categoria" do
    visit g_categoria_url(@g_categoria)
    click_on "Destroy this g categoria", match: :first

    assert_text "G categoria was successfully destroyed"
  end
end

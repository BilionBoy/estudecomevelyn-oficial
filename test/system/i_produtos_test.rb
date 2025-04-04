require "application_system_test_case"

class IProdutosTest < ApplicationSystemTestCase
  setup do
    @i_produto = i_produtos(:one)
  end

  test "visiting the index" do
    visit i_produtos_url
    assert_selector "h1", text: "I produtos"
  end

  test "should create i produto" do
    visit i_produtos_url
    click_on "New i produto"

    fill_in "Arquivo url", with: @i_produto.arquivo_url
    fill_in "Created by", with: @i_produto.created_by
    fill_in "Deleted at", with: @i_produto.deleted_at
    fill_in "Descricao", with: @i_produto.descricao
    fill_in "G categoria", with: @i_produto.g_categoria_id
    fill_in "Imagem url", with: @i_produto.imagem_url
    fill_in "Nome", with: @i_produto.nome
    fill_in "Preco", with: @i_produto.preco
    fill_in "Slug", with: @i_produto.slug
    fill_in "Status", with: @i_produto.status
    fill_in "Updated by", with: @i_produto.updated_by
    click_on "Create I produto"

    assert_text "I produto was successfully created"
    click_on "Back"
  end

  test "should update I produto" do
    visit i_produto_url(@i_produto)
    click_on "Edit this i produto", match: :first

    fill_in "Arquivo url", with: @i_produto.arquivo_url
    fill_in "Created by", with: @i_produto.created_by
    fill_in "Deleted at", with: @i_produto.deleted_at.to_s
    fill_in "Descricao", with: @i_produto.descricao
    fill_in "G categoria", with: @i_produto.g_categoria_id
    fill_in "Imagem url", with: @i_produto.imagem_url
    fill_in "Nome", with: @i_produto.nome
    fill_in "Preco", with: @i_produto.preco
    fill_in "Slug", with: @i_produto.slug
    fill_in "Status", with: @i_produto.status
    fill_in "Updated by", with: @i_produto.updated_by
    click_on "Update I produto"

    assert_text "I produto was successfully updated"
    click_on "Back"
  end

  test "should destroy I produto" do
    visit i_produto_url(@i_produto)
    click_on "Destroy this i produto", match: :first

    assert_text "I produto was successfully destroyed"
  end
end

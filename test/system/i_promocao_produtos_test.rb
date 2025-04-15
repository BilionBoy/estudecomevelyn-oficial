require "application_system_test_case"

class IPromocaoProdutosTest < ApplicationSystemTestCase
  setup do
    @i_promocao_produto = i_promocao_produtos(:one)
  end

  test "visiting the index" do
    visit i_promocao_produtos_url
    assert_selector "h1", text: "I promocao produtos"
  end

  test "should create i promocao produto" do
    visit i_promocao_produtos_url
    click_on "New i promocao produto"

    fill_in "I produto", with: @i_promocao_produto.i_produto_id
    fill_in "I promocao", with: @i_promocao_produto.i_promocao_id
    fill_in "Preco promocional", with: @i_promocao_produto.preco_promocional
    click_on "Create I promocao produto"

    assert_text "I promocao produto was successfully created"
    click_on "Back"
  end

  test "should update I promocao produto" do
    visit i_promocao_produto_url(@i_promocao_produto)
    click_on "Edit this i promocao produto", match: :first

    fill_in "I produto", with: @i_promocao_produto.i_produto_id
    fill_in "I promocao", with: @i_promocao_produto.i_promocao_id
    fill_in "Preco promocional", with: @i_promocao_produto.preco_promocional
    click_on "Update I promocao produto"

    assert_text "I promocao produto was successfully updated"
    click_on "Back"
  end

  test "should destroy I promocao produto" do
    visit i_promocao_produto_url(@i_promocao_produto)
    click_on "Destroy this i promocao produto", match: :first

    assert_text "I promocao produto was successfully destroyed"
  end
end

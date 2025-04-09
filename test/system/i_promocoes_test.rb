require "application_system_test_case"

class IPromocaosTest < ApplicationSystemTestCase
  setup do
    @i_promocao = i_promocoes(:one)
  end

  test "visiting the index" do
    visit i_promocoes_url
    assert_selector "h1", text: "I promocaos"
  end

  test "should create i promocao" do
    visit i_promocoes_url
    click_on "New i promocao"

    check "Ativo" if @i_promocao.ativo
    fill_in "Descricao", with: @i_promocao.descricao
    fill_in "Nome", with: @i_promocao.nome
    fill_in "Slug", with: @i_promocao.slug
    click_on "Create I promocao"

    assert_text "I promocao was successfully created"
    click_on "Back"
  end

  test "should update I promocao" do
    visit i_promocao_url(@i_promocao)
    click_on "Edit this i promocao", match: :first

    check "Ativo" if @i_promocao.ativo
    fill_in "Descricao", with: @i_promocao.descricao
    fill_in "Nome", with: @i_promocao.nome
    fill_in "Slug", with: @i_promocao.slug
    click_on "Update I promocao"

    assert_text "I promocao was successfully updated"
    click_on "Back"
  end

  test "should destroy I promocao" do
    visit i_promocao_url(@i_promocao)
    click_on "Destroy this i promocao", match: :first

    assert_text "I promocao was successfully destroyed"
  end
end

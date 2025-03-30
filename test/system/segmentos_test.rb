require "application_system_test_case"

class SegmentosTest < ApplicationSystemTestCase
  setup do
    @segmento = segmentos(:one)
  end

  test "visiting the index" do
    visit segmentos_url
    assert_selector "h1", text: "Segmentos"
  end

  test "should create segmento" do
    visit segmentos_url
    click_on "New segmento"

    fill_in "Descricao", with: @segmento.descricao
    fill_in "Nome", with: @segmento.nome
    click_on "Create Segmento"

    assert_text "Segmento was successfully created"
    click_on "Back"
  end

  test "should update Segmento" do
    visit segmento_url(@segmento)
    click_on "Edit this segmento", match: :first

    fill_in "Descricao", with: @segmento.descricao
    fill_in "Nome", with: @segmento.nome
    click_on "Update Segmento"

    assert_text "Segmento was successfully updated"
    click_on "Back"
  end

  test "should destroy Segmento" do
    visit segmento_url(@segmento)
    click_on "Destroy this segmento", match: :first

    assert_text "Segmento was successfully destroyed"
  end
end

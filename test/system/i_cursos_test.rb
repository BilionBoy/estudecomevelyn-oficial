require "application_system_test_case"

class ICursosTest < ApplicationSystemTestCase
  setup do
    @i_curso = i_cursos(:one)
  end

  test "visiting the index" do
    visit i_cursos_url
    assert_selector "h1", text: "I cursos"
  end

  test "should create i curso" do
    visit i_cursos_url
    click_on "New i curso"

    fill_in "Created by", with: @i_curso.created_by
    fill_in "Descricao", with: @i_curso.descricao
    fill_in "G categoria", with: @i_curso.g_categoria_id
    fill_in "Nome", with: @i_curso.nome
    fill_in "Preco", with: @i_curso.preco
    fill_in "Slug", with: @i_curso.slug
    fill_in "Status", with: @i_curso.status
    fill_in "Updated by", with: @i_curso.updated_by
    fill_in "Url externa", with: @i_curso.url_externa
    click_on "Create I curso"

    assert_text "I curso was successfully created"
    click_on "Back"
  end

  test "should update I curso" do
    visit i_curso_url(@i_curso)
    click_on "Edit this i curso", match: :first

    fill_in "Created by", with: @i_curso.created_by
    fill_in "Descricao", with: @i_curso.descricao
    fill_in "G categoria", with: @i_curso.g_categoria_id
    fill_in "Nome", with: @i_curso.nome
    fill_in "Preco", with: @i_curso.preco
    fill_in "Slug", with: @i_curso.slug
    fill_in "Status", with: @i_curso.status
    fill_in "Updated by", with: @i_curso.updated_by
    fill_in "Url externa", with: @i_curso.url_externa
    click_on "Update I curso"

    assert_text "I curso was successfully updated"
    click_on "Back"
  end

  test "should destroy I curso" do
    visit i_curso_url(@i_curso)
    click_on "Destroy this i curso", match: :first

    assert_text "I curso was successfully destroyed"
  end
end

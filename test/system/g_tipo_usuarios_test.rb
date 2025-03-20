require "application_system_test_case"

class GTipoUsuariosTest < ApplicationSystemTestCase
  setup do
    @g_tipo_usuario = g_tipo_usuarios(:one)
  end

  test "visiting the index" do
    visit g_tipo_usuarios_url
    assert_selector "h1", text: "G tipo usuarios"
  end

  test "should create g tipo usuario" do
    visit g_tipo_usuarios_url
    click_on "New g tipo usuario"

    fill_in "Descricao", with: @g_tipo_usuario.descricao
    fill_in "Nome", with: @g_tipo_usuario.nome
    click_on "Create G tipo usuario"

    assert_text "G tipo usuario was successfully created"
    click_on "Back"
  end

  test "should update G tipo usuario" do
    visit g_tipo_usuario_url(@g_tipo_usuario)
    click_on "Edit this g tipo usuario", match: :first

    fill_in "Descricao", with: @g_tipo_usuario.descricao
    fill_in "Nome", with: @g_tipo_usuario.nome
    click_on "Update G tipo usuario"

    assert_text "G tipo usuario was successfully updated"
    click_on "Back"
  end

  test "should destroy G tipo usuario" do
    visit g_tipo_usuario_url(@g_tipo_usuario)
    click_on "Destroy this g tipo usuario", match: :first

    assert_text "G tipo usuario was successfully destroyed"
  end
end

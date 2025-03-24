require "application_system_test_case"

class GUsuariosTest < ApplicationSystemTestCase
  setup do
    @g_usuario = g_usuarios(:one)
  end

  test "visiting the index" do
    visit g_usuarios_url
    assert_selector "h1", text: "G usuarios"
  end

  test "should create g usuario" do
    visit g_usuarios_url
    click_on "New g usuario"

    fill_in "Email", with: @g_usuario.email
    fill_in "Nome", with: @g_usuario.nome
    fill_in "Password digest", with: @g_usuario.password_digest
    fill_in "Tipo usuario", with: @g_usuario.tipo_usuario_id
    click_on "Create G usuario"

    assert_text "G usuario was successfully created"
    click_on "Back"
  end

  test "should update G usuario" do
    visit g_usuario_url(@g_usuario)
    click_on "Edit this g usuario", match: :first

    fill_in "Email", with: @g_usuario.email
    fill_in "Nome", with: @g_usuario.nome
    fill_in "Password digest", with: @g_usuario.password_digest
    fill_in "Tipo usuario", with: @g_usuario.tipo_usuario_id
    click_on "Update G usuario"

    assert_text "G usuario was successfully updated"
    click_on "Back"
  end

  test "should destroy G usuario" do
    visit g_usuario_url(@g_usuario)
    click_on "Destroy this g usuario", match: :first

    assert_text "G usuario was successfully destroyed"
  end
end

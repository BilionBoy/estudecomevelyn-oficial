require "test_helper"

class GTipoUsuariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_tipo_usuario = g_tipo_usuarios(:one)
  end

  test "should get index" do
    get g_tipo_usuarios_url
    assert_response :success
  end

  test "should get new" do
    get new_g_tipo_usuario_url
    assert_response :success
  end

  test "should create g_tipo_usuario" do
    assert_difference("GTipoUsuario.count") do
      post g_tipo_usuarios_url, params: { g_tipo_usuario: { descricao: @g_tipo_usuario.descricao, nome: @g_tipo_usuario.nome } }
    end

    assert_redirected_to g_tipo_usuario_url(GTipoUsuario.last)
  end

  test "should show g_tipo_usuario" do
    get g_tipo_usuario_url(@g_tipo_usuario)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_tipo_usuario_url(@g_tipo_usuario)
    assert_response :success
  end

  test "should update g_tipo_usuario" do
    patch g_tipo_usuario_url(@g_tipo_usuario), params: { g_tipo_usuario: { descricao: @g_tipo_usuario.descricao, nome: @g_tipo_usuario.nome } }
    assert_redirected_to g_tipo_usuario_url(@g_tipo_usuario)
  end

  test "should destroy g_tipo_usuario" do
    assert_difference("GTipoUsuario.count", -1) do
      delete g_tipo_usuario_url(@g_tipo_usuario)
    end

    assert_redirected_to g_tipo_usuarios_url
  end
end

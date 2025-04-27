require "test_helper"

class ICursosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @i_curso = i_cursos(:one)
  end

  test "should get index" do
    get i_cursos_url
    assert_response :success
  end

  test "should get new" do
    get new_i_curso_url
    assert_response :success
  end

  test "should create i_curso" do
    assert_difference("ICurso.count") do
      post i_cursos_url, params: { i_curso: { created_by: @i_curso.created_by, descricao: @i_curso.descricao, g_categoria_id: @i_curso.g_categoria_id, nome: @i_curso.nome, preco: @i_curso.preco, slug: @i_curso.slug, status: @i_curso.status, updated_by: @i_curso.updated_by, url_externa: @i_curso.url_externa } }
    end

    assert_redirected_to i_curso_url(ICurso.last)
  end

  test "should show i_curso" do
    get i_curso_url(@i_curso)
    assert_response :success
  end

  test "should get edit" do
    get edit_i_curso_url(@i_curso)
    assert_response :success
  end

  test "should update i_curso" do
    patch i_curso_url(@i_curso), params: { i_curso: { created_by: @i_curso.created_by, descricao: @i_curso.descricao, g_categoria_id: @i_curso.g_categoria_id, nome: @i_curso.nome, preco: @i_curso.preco, slug: @i_curso.slug, status: @i_curso.status, updated_by: @i_curso.updated_by, url_externa: @i_curso.url_externa } }
    assert_redirected_to i_curso_url(@i_curso)
  end

  test "should destroy i_curso" do
    assert_difference("ICurso.count", -1) do
      delete i_curso_url(@i_curso)
    end

    assert_redirected_to i_cursos_url
  end
end

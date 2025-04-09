require "test_helper"

class IPromocoesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @i_promocao = i_promocoes(:one)
  end

  test "should get index" do
    get i_promocoes_url
    assert_response :success
  end

  test "should get new" do
    get new_i_promocao_url
    assert_response :success
  end

  test "should create i_promocao" do
    assert_difference("IPromocao.count") do
      post i_promocoes_url, params: { i_promocao: { ativo: @i_promocao.ativo, descricao: @i_promocao.descricao, nome: @i_promocao.nome, slug: @i_promocao.slug } }
    end

    assert_redirected_to i_promocao_url(IPromocao.last)
  end

  test "should show i_promocao" do
    get i_promocao_url(@i_promocao)
    assert_response :success
  end

  test "should get edit" do
    get edit_i_promocao_url(@i_promocao)
    assert_response :success
  end

  test "should update i_promocao" do
    patch i_promocao_url(@i_promocao), params: { i_promocao: { ativo: @i_promocao.ativo, descricao: @i_promocao.descricao, nome: @i_promocao.nome, slug: @i_promocao.slug } }
    assert_redirected_to i_promocao_url(@i_promocao)
  end

  test "should destroy i_promocao" do
    assert_difference("IPromocao.count", -1) do
      delete i_promocao_url(@i_promocao)
    end

    assert_redirected_to i_promocoes_url
  end
end

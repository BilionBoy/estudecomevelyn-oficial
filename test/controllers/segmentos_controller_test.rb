require "test_helper"

class SegmentosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @segmento = segmentos(:one)
  end

  test "should get index" do
    get segmentos_url
    assert_response :success
  end

  test "should get new" do
    get new_segmento_url
    assert_response :success
  end

  test "should create segmento" do
    assert_difference("Segmento.count") do
      post segmentos_url, params: { segmento: { descricao: @segmento.descricao, nome: @segmento.nome } }
    end

    assert_redirected_to segmento_url(Segmento.last)
  end

  test "should show segmento" do
    get segmento_url(@segmento)
    assert_response :success
  end

  test "should get edit" do
    get edit_segmento_url(@segmento)
    assert_response :success
  end

  test "should update segmento" do
    patch segmento_url(@segmento), params: { segmento: { descricao: @segmento.descricao, nome: @segmento.nome } }
    assert_redirected_to segmento_url(@segmento)
  end

  test "should destroy segmento" do
    assert_difference("Segmento.count", -1) do
      delete segmento_url(@segmento)
    end

    assert_redirected_to segmentos_url
  end
end

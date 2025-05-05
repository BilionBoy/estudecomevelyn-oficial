module CarrinhoHelper
  def total_carrinho_anonimo
    return 0 unless session[:carrinho]

    session[:carrinho].sum do |produto_id, quantidade|
      produto = IProduto.find_by(id: produto_id)
      produto ? produto.preco * quantidade : 0
    end
  end
end

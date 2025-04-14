module CarrinhoHelper
  def total_carrinho
    total = 0
    session[:carrinho].each do |produto_id, quantidade|
      produto = IProduto.find(produto_id)
      total += produto.preco * quantidade
    end
    total
  end
end

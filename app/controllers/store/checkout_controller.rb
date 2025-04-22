class Store::CheckoutController < ApplicationController
  def new
    @carrinho = current_user.i_carrinho # Supondo que o usuário tem um carrinho
    @pedido = i_pedidos.new
  end

  def create
    @carrinho = current_user.i_carrinho
    @pedido = current_user.i_pedidos.create!(pedido_params)
    
    @carrinho.i_itens_carrinhos.each do |item|
      @pedido.i_itens_pedidos.create!(
        i_produto: item.i_produto,
        quantidade: item.quantidade,
        preco_unitario: item.preco_unitario,
        subtotal: item.subtotal
      )
    end

    @pedido.update!(status: 'Criado', total: @carrinho.total)

    redirect_to store_checkout_path(@pedido)
  end

  private

  def pedido_params
    params.require(:i_pedido).permit(:total, :status)
  end
end

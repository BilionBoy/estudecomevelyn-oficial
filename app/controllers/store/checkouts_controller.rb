class Store::CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_carrinho

  def success
    @pedido = IPedido.new(
      usuario:  current_user,
      total:    @carrinho.total,
      status:   :confirmado 


    )
    @carrinho.i_itens_carrinhos.each do |item|
      @pedido.i_itens_pedidos.build(
        i_produto: item.i_produto,
        quantidade: item.quantidade,
        preco_unitario: item.preco_unitario,
        subtotal: item.subtotal
      )
    end

    if @pedido.save
      @carrinho.update(status: 'finalizado')
      redirect_to store_pedido_path(@pedido), notice: 'Pedido confirmado após pagamento!'
    else
      redirect_to store_cart_path, alert: 'Erro ao salvar o pedido após pagamento.'
    end
  end

  def cancel
    redirect_to store_cart_path, alert: 'Pagamento cancelado. Você pode tentar novamente.'
  end

  private

  def set_carrinho
    @carrinho = current_user.carrinho_ativo
  end
end

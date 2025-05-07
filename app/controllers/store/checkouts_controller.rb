class Store::CheckoutsController < ApplicationController
  def new
    @carrinho = current_user.carrinho_ativo
    @pedido = IPedido.new
  end

  def create
    @carrinho = current_user.carrinho_ativo

    # Cria o pedido
    @pedido = IPedido.new(usuario: current_user, total: @carrinho.total)

    # Associa os itens do carrinho ao pedido
    @carrinho.i_itens_carrinhos.each do |item|
      @pedido.i_itens_pedidos.build(
        i_produto: item.i_produto,
        quantidade: item.quantidade,
        preco_unitario: item.preco_unitario,
        subtotal: item.subtotal
      )
    end

    if @pedido.save
      # Finaliza o carrinho
      @carrinho.update(status: 'finalizado')

      redirect_to pedido_path(@pedido), notice: 'Pedido realizado com sucesso!'
    else
      render :new, alert: 'Houve um erro ao processar o pedido.'
    end
  end
end

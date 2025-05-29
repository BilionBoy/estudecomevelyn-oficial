class Store::PedidosController < ApplicationController
  def index
    @pedidos = current_user.i_pedidos
  end

   def show
    @i_pedido = current_user.i_pedidos.find_by(id: params[:id])
    
    # Se não encontrar o pedido, redirecionar
    if @i_pedido.nil?
      redirect_to store_pedidos_path, alert: "Pedido não encontrado."
      return
    end
    
    @itens = @i_pedido.i_itens_pedidos
    @total = @i_pedido.total
   end

  def create
    carrinho = current_user.i_carrinho

    pedido = current_user.i_pedidos.create!(
      status: 'Criado',
      total: carrinho.total
    )

    carrinho.i_itens_carrinhos.each do |item|
      pedido.i_itens_pedidos.create!(
        i_produto: item.i_produto,
        quantidade: item.quantidade,
        preco_unitario: item.preco_unitario,
        subtotal: item.subtotal
      )
    end

    carrinho.limpar! # opcional: limpar o carrinho depois

    redirect_to store_pedido_path(pedido), notice: "Pedido criado com sucesso!"
  end


end

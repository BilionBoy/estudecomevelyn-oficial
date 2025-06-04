class Store::PedidosController < ApplicationController
  before_action :authenticate_user!

  def index
    @pedidos = current_user.i_pedidos
  end

  def show
    @i_pedido = current_user.i_pedidos.find_by(id: params[:id])
    unless @i_pedido
      redirect_to store_pedidos_path, alert: "Pedido não encontrado." and return
    end
    @itens = @i_pedido.i_itens_pedidos
    @total = @i_pedido.total
  end

end

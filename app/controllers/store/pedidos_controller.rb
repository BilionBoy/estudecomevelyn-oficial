class Store::PedidosController < ApplicationController
  def index
    @pedidos = current_user.i_pedidos
  end

  def show
    @pedido = current_user.i_pedidos.find(params[:id])
  end
end

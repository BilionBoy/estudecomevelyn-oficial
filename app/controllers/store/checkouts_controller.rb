# app/controllers/store/checkouts_controller.rb
class Store::CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_carrinho

  def success
    @pedido = IPedido.new(
      usuario: current_user,
      total: @carrinho.total,
      )
      @pedido.status = :confirmado

    # Copia os itens do carrinho para os itens do pedido
    @carrinho.i_itens_carrinhos.each do |item|
      @pedido.i_itens_pedidos.build(
        i_produto: item.i_produto,
        quantidade: item.quantidade,
        preco_unitario: item.preco_unitario,
        subtotal: item.subtotal
      )
    end

    if @pedido.save
      @carrinho.update(status: :finalizado)
       
      # Opcional: Enviar e-mail de confirmação aqui (future step)
      # ✅ Envia o e-mail com o(s) produto(s) em anexo
      PedidoMailer.enviar_infoprodutos(@pedido.id).deliver_now

    redirect_to g_admin_meus_pedidos_path, notice: 'Pedido confirmado após pagamento!'
    else
      Rails.logger.error "Erro ao salvar pedido: #{@pedido.errors.full_messages.to_sentence}"
      redirect_to store_cart_path, alert: 'Erro ao salvar o pedido após pagamento.'
    end
  end

  def cancel
    redirect_to store_cart_path, alert: 'Pagamento cancelado. Você pode tentar novamente.'
  end

  private

  def set_carrinho
    @carrinho = current_user.carrinho_ativo
    redirect_to store_root_path, alert: 'Carrinho não encontrado.' unless @carrinho
  end
end

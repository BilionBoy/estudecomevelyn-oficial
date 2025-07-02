class Store::PixController < ApplicationController
  before_action :authenticate_user!
  before_action :set_carrinho

  def pagar
    customer_service = Store::Pix::CustomerService.new
    payment_service = Store::Pix::PaymentService.new

    # Cria ou recupera o customer no Asaas
    customer_service.create_customer_for(current_user)

    # Cria a cobrança Pix no Asaas
    payment = payment_service.create_payment_for(
      current_user,
      value: @carrinho.total,
      due_date: Date.today + 1,
      external_reference: "pedido_#{current_user.id}_#{Time.now.to_i}"
    )

    # Renderiza a view passando o payment com qrCode
    render :pagar, locals: { payment: payment }
  rescue Store::Pix::AsaasClient::RequestError => e
    redirect_to store_carrinho_path, alert: "Erro ao gerar Pix: #{e.message}"
  end

  private

  def set_carrinho
    @carrinho = current_user.carrinho_ativo
    redirect_to store_carrinho_path, alert: 'Carrinho não encontrado.' unless @carrinho
  end
end

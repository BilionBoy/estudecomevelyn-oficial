module Store
  class PixController < ApplicationController
    before_action :authenticate_user!
    before_action :set_carrinho

    def pagar
      customer_service = Store::Pix::CustomerService.new
      payment_service  = Store::Pix::PaymentService.new

      customer_service.create_customer_for(current_user)

      @payment = payment_service.create_payment_for(
        current_user,
        value: @carrinho.total,
        due_date: Date.tomorrow,
        external_reference: "pedido_#{current_user.id}_#{Time.now.to_i}"
      )

      render :pagar
    rescue Store::Pix::AsaasClient::RequestError => e
      flash[:alert] = "Erro ao gerar PIX: #{e.message}"
      redirect_to store_carrinho_path
    end

    private

    def set_carrinho
      @carrinho = current_user.carrinho_ativo
    end
  end
end

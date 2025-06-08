# app/controllers/store/carrinho_controller.rb
class Store::CarrinhoController < ApplicationController
  before_action :authenticate_user!
  before_action :set_carrinho, only: [:show, :adicionar, :remover, :limpar, :finalizar_compra]
  def show
    @itens = @carrinho.i_itens_carrinhos
    @total = @carrinho.total
  end

  def adicionar
    service = Store::Carrinho::AdicionarItemAoCarrinhoService.new(carrinho: @carrinho,produto_id: params[:produto_id])
    resultado = service.call
  
    render json: resultado
  rescue Store::Carrinho::AdicionarItemAoCarrinhoService::ProdutoNaoEncontrado => e
    render json: { success: false, message: e.message }, status: :not_found
  rescue => e
    render json: { success: false, message: e.message }, status: :unprocessable_entity
  end



  def remover
    service   = Store::Carrinho::RemoverItemDoCarrinhoService.new(carrinho: @carrinho,produto_id: params[:produto_id])
    resultado = service.call
     
    flash[:notice] = resultado[:message]
  
  rescue Store::Carrinho::RemoverItemDoCarrinhoService::ProdutoNaoEncontrado,
         Store::Carrinho::RemoverItemDoCarrinhoService::ItemNaoEncontrado => e
    flash[:alert] = e.message
  ensure
    redirect_to store_carrinho_path
  end


  def limpar
    if @carrinho.i_itens_carrinhos.empty?
      flash[:alert] = "O carrinho já está vazio."
    else
      @carrinho.i_itens_carrinhos.destroy_all
      flash[:notice] = "Carrinho esvaziado com sucesso."
    end
    redirect_to store_carrinho_path
  end

  def finalizar_compra
    if @carrinho.i_itens_carrinhos.empty?
      redirect_to store_carrinho_path, alert: 'Seu carrinho está vazio.'
      return
    end

    Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)

    begin
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: @carrinho.i_itens_carrinhos.map do |item|
          {
            price_data: {
              currency: 'brl',
              product_data: { name: item.i_produto.nome },
              unit_amount: (item.i_produto.preco * 100).to_i,
            },
            quantity: item.quantidade,
          }
        end,
        mode: 'payment',
        success_url: store_checkout_success_url, # ou outra rota que mostra pedido ou confirmação
        cancel_url: store_carrinho_url,
        customer_email: current_user.email,
      )

      redirect_to session.url, allow_other_host: true
    rescue Stripe::StripeError => e
      flash[:alert] = "Erro ao iniciar pagamento: #{e.message}"
      redirect_to store_carrinho_path
    end
  end

  private

  def set_carrinho
    @carrinho = current_user.carrinho_ativo
  end
end

# app/controllers/store/carrinho_controller.rb
class Store::CarrinhoController < ApplicationController
  before_action :authenticate_user!
  before_action :set_carrinho, only: [:show, :adicionar, :remover, :limpar, :finalizar_compra]
  def show
    @itens = @carrinho.i_itens_carrinhos
    @total = @carrinho.total
  end

  def adicionar
    produto = IProduto.find_by(id: params[:produto_id])
    unless produto
      return render json: { success: false, message: "Produto não encontrado." }, status: :not_found
    end
    
    item_ja_existe = @carrinho.item_presente?(produto)
    @carrinho.adicionar_item(produto)

    render json: {
      success: true,
      total_itens: @carrinho.quantidade_total_itens,
      item_ja_estava_no_carrinho: item_ja_existe
    }
  rescue => e
    render json: { success: false, message: e.message }, status: :unprocessable_entity
  end

  def remover
    produto = IProduto.find_by(id: params[:produto_id])
    unless produto
      flash[:alert] = "Produto não encontrado."
      return redirect_to store_carrinho_path
    end
    
    item = @carrinho.i_itens_carrinhos.find_by(i_produto: produto)

    if item
      item.destroy
      flash[:notice] = "Item removido com sucesso."
    else
      flash[:alert] = "Item não encontrado no carrinho."
    end

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

class Store::CheckoutsController < ApplicationController
  def new
    @carrinho = current_user.carrinho_ativo
    @pedido = IPedido.new
  end

  def create
    @carrinho = current_user.carrinho_ativo

    if @carrinho.i_itens_carrinhos.empty?
      redirect_to store_cart_path, alert: 'Seu carrinho está vazio.'
      return
    end

    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: @carrinho.i_itens_carrinhos.map do |item|
        {
          price_data: {
            currency: 'brl',
            product_data: {
              name: item.i_produto.nome,
            },
            unit_amount: (item.preco_unitario * 100).to_i,
          },
          quantity: item.quantidade,
        }
      end,
      mode: 'payment',
      success_url: store_checkout_success_url,  
      cancel_url: store_checkout_cancel_url,    
    })

    redirect_to session.url, allow_other_host: true
  end

  def success
    @carrinho = current_user.carrinho_ativo

    # Cria o pedido com base no carrinho
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

    # Salva o pedido e finaliza o carrinho
    if @pedido.save
      @carrinho.update(status: 'finalizado')
      redirect_to pedido_path(@pedido), notice: 'Pedido confirmado após pagamento!'
    else
      redirect_to store_cart_path, alert: 'Erro ao salvar o pedido após pagamento.'
    end
  end

  def cancel
    # Redireciona caso o pagamento seja cancelado
    redirect_to store_cart_path, alert: 'Pagamento cancelado. Você pode tentar novamente.'
  end
end

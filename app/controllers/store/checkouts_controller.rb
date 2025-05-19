class Store::CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_carrinho
  before_action :set_stripe_api_key, only: :create

  def new
    @carrinho = current_user.carrinho_ativo
    @pedido = IPedido.new
    
    # Redirecionar se o carrinho estiver vazio
    if @carrinho.i_itens_carrinhos.empty?
      redirect_to store_cart_path, alert: 'Seu carrinho está vazio.'
      return
    end
  end

  def create
    # Validar dados do formulário
    unless valid_checkout_params?
      flash[:alert] = 'Por favor, preencha todos os campos obrigatórios.'
      redirect_to new_store_checkout_path
      return
    end
    
    # Verificar se o carrinho está vazio
    if @carrinho.i_itens_carrinhos.empty?
      redirect_to store_cart_path, alert: 'Seu carrinho está vazio.'
      return
    end

    # Criar sessão do Stripe com base no método de pagamento
    case params[:payment_method]
    when 'credit_card'
      create_stripe_checkout_session
    when 'boleto'
      create_boleto_checkout
    when 'pix'
      create_pix_checkout
    else
      redirect_to new_store_checkout_path, alert: 'Método de pagamento inválido.'
    end
  end

  def success
    @carrinho = current_user.carrinho_ativo

    # Cria o pedido com base no carrinho
    @pedido = IPedido.new(
      usuario: current_user, 
      total: @carrinho.total,
      nome: session[:checkout_data]['nome'],
      email: session[:checkout_data]['email'],
      cpf: session[:checkout_data]['cpf'],
      telefone: session[:checkout_data]['telefone'],
      metodo_pagamento: session[:checkout_data]['payment_method']
    )

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
      # Limpar dados temporários da sessão
      session.delete(:checkout_data)
      redirect_to store_pedido_path(@pedido), notice: 'Pedido confirmado após pagamento!'
    else
      redirect_to store_cart_path, alert: 'Erro ao salvar o pedido após pagamento.'
    end
  end

  def cancel
    # Redireciona caso o pagamento seja cancelado
    redirect_to store_cart_path, alert: 'Pagamento cancelado. Você pode tentar novamente.'
  end

  private
  
  def set_carrinho
    @carrinho = current_user.carrinho_ativo
  end

  def set_stripe_api_key
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
    Rails.logger.info "Stripe API Key configurada: #{Stripe.api_key.present? ? 'Presente' : 'Ausente'}"
  end
  
  def valid_checkout_params?
    # Validar campos obrigatórios
    required_fields = ['nome', 'email', 'cpf', 'telefone']
    
    # Adicionar validações específicas para cartão de crédito
    if params[:payment_method] == 'credit_card'
      required_fields += ['card_number', 'card_name', 'card_expiry', 'card_cvv']
    end
    
    # Verificar se todos os campos obrigatórios estão preenchidos
    required_fields.all? { |field| params[field].present? }
  end
  
  def create_stripe_checkout_session
    # Verificar se a chave API está configurada
    if Stripe.api_key.blank?
      Rails.logger.error "Stripe API Key não está configurada!"
      set_stripe_api_key
      
      # Se ainda estiver em branco, retornar erro
      if Stripe.api_key.blank?
        redirect_to new_store_checkout_path, alert: 'Erro na configuração do pagamento. Por favor, tente novamente mais tarde.'
        return
      end
    end
    
    session[:checkout_data] = {
      'nome' => params[:nome],
      'email' => params[:email],
      'cpf' => params[:cpf],
      'telefone' => params[:telefone],
      'payment_method' => params[:payment_method]
    }

    begin
      stripe_session = Stripe::Checkout::Session.create({
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
        customer_email: params[:email],
        success_url: store_checkout_success_url,
        cancel_url: store_checkout_cancel_url,
      })

      redirect_to stripe_session.url, allow_other_host: true
    rescue Stripe::AuthenticationError => e
      Rails.logger.error "Erro de autenticação Stripe: #{e.message}"
      redirect_to new_store_checkout_path, alert: 'Erro na autenticação do pagamento. Por favor, tente novamente mais tarde.'
    rescue => e
      Rails.logger.error "Erro ao criar sessão Stripe: #{e.message}"
      redirect_to new_store_checkout_path, alert: 'Erro ao processar o pagamento. Por favor, tente novamente mais tarde.'
    end
  end
  
  def create_boleto_checkout
    # Implementar lógica para boleto
    # Este é um exemplo simplificado - você precisará integrar com um provedor de boletos
    session[:checkout_data] = {
      'nome' => params[:nome],
      'email' => params[:email],
      'cpf' => params[:cpf],
      'telefone' => params[:telefone],
      'payment_method' => 'boleto'
    }
    
    # Aqui você integraria com um serviço de boleto
    # Por enquanto, vamos simular redirecionando para a página de sucesso
    redirect_to store_checkout_success_path
  end
  
  def create_pix_checkout
    # Implementar lógica para PIX
    # Este é um exemplo simplificado - você precisará integrar com um provedor de PIX
    session[:checkout_data] = {
      'nome' => params[:nome],
      'email' => params[:email],
      'cpf' => params[:cpf],
      'telefone' => params[:telefone],
      'payment_method' => 'pix'
    }
    
    # Aqui você integraria com um serviço de PIX
    # Por enquanto, vamos simular redirecionando para a página de sucesso
    redirect_to store_checkout_success_path
  end
end

class Store::CarrinhoController < ApplicationController
  before_action :set_carrinho, only: [:index, :add, :remove, :clear]

  def index
  end

  def add
    # Recuperar o produto baseado no ID (ou slug)
    produto = IProduto.find(params[:produto_id])

    # Adicionar o produto ao carrinho (assumindo que o carrinho é armazenado em sessão)
    session[:carrinho] ||= []
    session[:carrinho] << produto.id

    # Retornar resposta para o frontend
    respond_to do |format|
      format.js { render 'store/carrinho/add' } # Exemplo de resposta em JS
    end
  end
  
  def remove
    produto = IProduto.find(params[:produto_id])
    
    # Remove o produto ou decrementa a quantidade
    if session[:carrinho][produto.id.to_s].to_i > 1
      session[:carrinho][produto.id.to_s] -= 1
    else
      session[:carrinho].delete(produto.id.to_s)
    end
    
    redirect_to store_carrinho_path
  end

  def clear
    session[:carrinho] = {}
    redirect_to store_carrinho_path
  end

  private

  def set_carrinho
    session[:carrinho] ||= {}
  end
end

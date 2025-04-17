class Store::CarrinhoController < ApplicationController
  before_action :set_carrinho, only: [:show, :adicionar_item]

  def show
    @itens = @carrinho.i_itens_carrinhos
    @total = @carrinho.total
  end

  def adicionar_item
    produto = IProduto.find(params[:produto_id])
    quantidade = params[:quantidade].to_i
    @carrinho.adicionar_item(produto, quantidade)

    redirect_to carrinho_path, notice: 'Produto adicionado ao carrinho.'
  end

  private

  def set_carrinho
    @carrinho = current_user.i_carrinhos.find_or_create_by(status: 'ativo')
  end
end

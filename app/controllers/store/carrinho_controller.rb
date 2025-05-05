# app/controllers/store/carrinho_controller.rb
class Store::CarrinhoController < ApplicationController
  before_action :set_carrinho, only: [:show, :adicionar, :remover, :limpar]

  def show
    @itens = @carrinho.i_itens_carrinhos
    @total = @carrinho.total
  end

  def adicionar
    produto = IProduto.find(params[:produto_id])
    item_ja_existe = @carrinho.item_presente?(produto)
    @carrinho.adicionar_item(produto)

    render json: {
      success: true,
      total_itens: @carrinho.quantidade_total_itens,
      item_ja_estava_no_carrinho: item_ja_existe
    }
  rescue ActiveRecord::RecordNotFound
    render json: { success: false, message: "Produto não encontrado." }, status: :not_found
  rescue => e
    render json: { success: false, message: e.message }, status: :unprocessable_entity
  end

  def remover
    produto = IProduto.find(params[:produto_id])
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
    @carrinho.i_itens_carrinhos.destroy_all
    redirect_to store_carrinho_path, notice: "Carrinho esvaziado com sucesso."
  end

  private

  def set_carrinho
    @carrinho = current_user.carrinho_ativo
  end
end

# app/controllers/store/carrinho_controller.rb
class Store::CarrinhoController < ApplicationController
  before_action :set_carrinho, only: [:show, :adicionar]

  def show
    @itens = @carrinho.i_itens_carrinhos
    @total = @carrinho.total
  end


  def adicionar
    produto = IProduto.find(params[:produto_id])
    carrinho = current_user.i_carrinhos.find_or_create_by(status: 'ativo')

    item = carrinho.i_itens_carrinhos.find_or_initialize_by(i_produto: produto)
    item.quantidade ||= 0
    item.quantidade += 1
    item.save!

    total_itens = carrinho.i_itens_carrinhos.sum(:quantidade)

    respond_to do |format|
      format.json { render json: { success: true, total_itens: total_itens } }
    end
  rescue => e
    render json: { success: false, message: e.message }, status: :unprocessable_entity
  end

  def limpar
    carrinho = current_user.i_carrinhos.find_by(status: 'ativo')
    carrinho.i_itens_carrinhos.destroy_all if carrinho
    redirect_to carrinho_path, notice: "Carrinho esvaziado com sucesso."
  end
  

  private

  def set_carrinho
    @carrinho = current_user.i_carrinhos.find_or_create_by(status: 'ativo')
  end
end

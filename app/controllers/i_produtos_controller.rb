# frozen_string_literal: true
class IProdutosController < ApplicationController
  before_action :set_i_produto, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = IProduto.ransack(params[:q])
    @pagy, @i_produtos = pagy(@q.result)
  end

  def new
    @i_produto = IProduto.new
  end

  def edit
  end

  def create
    @i_produto = IProduto.new(i_produto_params)

    if @i_produto.save
      redirect_to i_produtos_path, notice: t('Criado com Sucesso!')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @i_produto.update(i_produto_params)
      redirect_to i_produtos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

def destroy
  if @i_produto.status != "inativo"
    redirect_to i_produtos_url, notice: "Só é possível excluir produtos com status 'inativo', altere o status do produto."
  else
    @i_produto.i_itens_carrinhos.destroy_all

    if @i_produto.destroy
      redirect_to i_produtos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to i_produtos_url, notice: t('messages.delete_failed_due_to_dependencies')
    end
  end
end



  private

  def set_i_produto
    @i_produto = IProduto.friendly.find(params[:id])
    return redirect_to i_produtos_path, alert: t('messages.not_found') unless @i_produto
  end

  def i_produto_params
    permitted_attributes = IProduto.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:i_produto).permit(*permitted_attributes.map(&:to_sym), :arquivo, :imagem, :remove_imagem)
  end
  
  def handle_not_found
    redirect_to i_produtos_path, alert: t('messages.not_found')
  end
end

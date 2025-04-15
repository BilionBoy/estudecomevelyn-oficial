# frozen_string_literal: true
class IPromocaoProdutosController < ApplicationController
  before_action :set_i_promocao_produto, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = IPromocaoProduto.ransack(params[:q])
    @pagy, @i_promocao_produtos = pagy(@q.result)
  end

  def new
    @i_promocao_produto = IPromocaoProduto.new
  end

  def edit
  end

  def create
    @i_promocao_produto = IPromocaoProduto.new(i_promocao_produto_params)

    if @i_promocao_produto.save
      redirect_to i_promocao_produtos_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @i_promocao_produto.update(i_promocao_produto_params)
      redirect_to i_promocao_produtos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @i_promocao_produto.destroy
      redirect_to i_promocao_produtos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to i_promocao_produtos_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_i_promocao_produto
    @i_promocao_produto = IPromocaoProduto.find_by(id: params[:id])
    return redirect_to i_promocao_produtos_path, alert: t('messages.not_found') unless @i_promocao_produto
  end

  def i_promocao_produto_params
    permitted_attributes = IPromocaoProduto.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:i_promocao_produto).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to i_promocao_produtos_path, alert: t('messages.not_found')
  end
end

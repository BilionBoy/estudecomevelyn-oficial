# frozen_string_literal: true
class GCategoriasController < ApplicationController
  before_action :set_g_categoria, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GCategoria.ransack(params[:q])
    @pagy, @g_categorias = pagy(@q.result)
  end

  def new
    @g_categoria = GCategoria.new
  end

  def edit
  end

  def create
    @g_categoria = GCategoria.new(g_categoria_params)

    if @g_categoria.save
      redirect_to g_categorias_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_categoria.update(g_categoria_params)
      redirect_to g_categorias_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_categoria.destroy
      redirect_to g_categorias_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_categorias_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_categoria
    @g_categoria = GCategoria.find_by(id: params[:id])
    return redirect_to g_categorias_path, alert: t('messages.not_found') unless @g_categoria
  end

  def g_categoria_params
    permitted_attributes = GCategoria.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_categoria).permit(permitted_attributes.map(&:to_sym), :foto_categoria, :remove_foto_categoria)
  end

  def handle_not_found
    redirect_to g_categorias_path, alert: t('messages.not_found')
  end
end

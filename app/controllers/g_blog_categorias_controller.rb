# frozen_string_literal: true
class GBlogCategoriasController < ApplicationController
  before_action :set_g_blog_categoria, only: %i[show edit update destroy]
  load_and_authorize_resource
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GBlogCategoria.ransack(params[:q])
    @pagy, @g_blog_categorias = pagy(@q.result)
  end

  def new
    @g_blog_categoria = GBlogCategoria.new
  end

  def edit
  end

  def create
    @g_blog_categoria = GBlogCategoria.new(g_blog_categoria_params)

    if @g_blog_categoria.save
      redirect_to g_blog_categorias_path, notice: t('Criado com Sucesso!')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_blog_categoria.update(g_blog_categoria_params)
      redirect_to g_blog_categorias_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_blog_categoria.destroy
      redirect_to g_blog_categorias_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_blog_categorias_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_blog_categoria
    @g_blog_categoria = GBlogCategoria.find_by(id: params[:id])
    return redirect_to g_blog_categorias_path, alert: t('messages.not_found') unless @g_blog_categoria
  end

  def g_blog_categoria_params
    permitted_attributes = GBlogCategoria.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_blog_categoria).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_blog_categorias_path, alert: t('messages.not_found')
  end
end

# frozen_string_literal: true
class ICursosController < ApplicationController
  before_action :set_i_curso, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = ICurso.ransack(params[:q])
    @pagy, @i_cursos = pagy(@q.result)
  end

  def new
    @i_curso = ICurso.new
  end

  def edit
  end

  def create
    @i_curso = ICurso.new(i_curso_params)

    if @i_curso.save
      redirect_to i_cursos_path, notice: t('Criado com Sucesso')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @i_curso.update(i_curso_params)
      redirect_to i_cursos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @i_curso.destroy
      redirect_to i_cursos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to i_cursos_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_i_curso
    @i_curso = ICurso.friendly.find(params[:id])
    return redirect_to i_cursos_path, alert: t('messages.not_found') unless @i_curso
  end

  def i_curso_params
    permitted_attributes = ICurso.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:i_curso).permit(permitted_attributes.map(&:to_sym), :imagem_capa, :remove_imagem_capa)
  end

  def handle_not_found
    redirect_to i_cursos_path, alert: t('messages.not_found')
  end
end

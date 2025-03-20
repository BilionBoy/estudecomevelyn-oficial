# frozen_string_literal: true
class GTipoUsuariosController < ApplicationController
  before_action :set_g_tipo_usuario, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GTipoUsuario.ransack(params[:q])
    @pagy, @g_tipo_usuarios = pagy(@q.result)
  end

  def new
    @g_tipo_usuario = GTipoUsuario.new
  end

  def edit
  end

  def create
    @g_tipo_usuario = GTipoUsuario.new(g_tipo_usuario_params)

    if @g_tipo_usuario.save
      redirect_to g_tipo_usuarios_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_tipo_usuario.update(g_tipo_usuario_params)
      redirect_to g_tipo_usuarios_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_tipo_usuario.destroy
      redirect_to g_tipo_usuarios_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_tipo_usuarios_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_tipo_usuario
    @g_tipo_usuario = GTipoUsuario.find_by(id: params[:id])
    return redirect_to g_tipo_usuarios_path, alert: t('messages.not_found') unless @g_tipo_usuario
  end

  def g_tipo_usuario_params
    permitted_attributes = GTipoUsuario.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_tipo_usuario).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_tipo_usuarios_path, alert: t('messages.not_found')
  end
end

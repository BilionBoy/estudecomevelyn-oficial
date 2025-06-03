# frozen_string_literal: true
class SegmentosController < ApplicationController
  before_action :set_segmento, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Segmento.ransack(params[:q])
    @pagy, @segmentos = pagy(@q.result)
  end

  def new
    @segmento = Segmento.new
  end

  def edit
  end

  def create
    @segmento = Segmento.new(segmento_params)

    if @segmento.save
      redirect_to segmentos_path, notice: t('Criado com Sucesso!')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @segmento.update(segmento_params)
      redirect_to segmentos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @segmento.destroy
      redirect_to segmentos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to segmentos_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_segmento
    @segmento = Segmento.find_by(id: params[:id])
    return redirect_to segmentos_path, alert: t('messages.not_found') unless @segmento
  end

  def segmento_params
    permitted_attributes = Segmento.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:segmento).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to segmentos_path, alert: t('messages.not_found')
  end
end

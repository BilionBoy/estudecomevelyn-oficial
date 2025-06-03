# frozen_string_literal: true
class IPromocoesController < ApplicationController
  before_action :set_i_promocao, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = IPromocao.ransack(params[:q])
    @pagy, @i_promocoes = pagy(@q.result)
  end

  def new
    @i_promocao = IPromocao.new
  end

  def edit
  end

  def create
    @i_promocao = IPromocao.new(i_promocao_params)

    if @i_promocao.save
      redirect_to i_promocoes_path, notice: t('Criado com Sucesso!')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @i_promocao.update(i_promocao_params)
      redirect_to i_promocoes_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @i_promocao.destroy
      redirect_to i_promocoes_url, notice: t('messages.deleted_successfully')
    else
      redirect_to i_promocoes_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_i_promocao
    @i_promocao = IPromocao.find_by(id: params[:id])
    return redirect_to i_promocoes_path, alert: t('messages.not_found') unless @i_promocao
  end

  def i_promocao_params
    permitted_attributes = IPromocao.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:i_promocao).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to i_promocoes_path, alert: t('messages.not_found')
  end
end

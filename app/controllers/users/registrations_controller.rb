# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  def cancel
    super
  end

  protected

  # Permite parâmetros adicionais no cadastro do Devise
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :g_tipo_usuario_id])
  end

  # Permite parâmetros adicionais na atualização da conta do usuário
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:nome, :g_tipo_usuario_id])
  end

  # Redireciona para a página inicial após o registro
  def after_sign_up_path_for(resource)
    root_path
  end

  # Redireciona para a página inicial após ativação de conta inativa
  def after_inactive_sign_up_path_for(resource)
    root_path
  end
end

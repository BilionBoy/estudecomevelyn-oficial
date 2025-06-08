# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :html, :json
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        
        respond_to do |format|
          format.html { redirect_to after_sign_up_path_for(resource) }
          format.json { 
            render json: { 
              success: true, 
              message: 'Conta criada com sucesso!',
              redirect_url: after_sign_up_path_for(resource)
            }
          }
        end
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_up!
        
        respond_to do |format|
          format.html { redirect_to after_inactive_sign_up_path_for(resource) }
          format.json { 
            render json: { 
              success: true, 
              message: 'Conta criada! Verifique seu email para ativar.',
              redirect_url: after_inactive_sign_up_path_for(resource)
            }
          }
        end
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { 
          render json: { 
            success: false, 
            error: 'Erro ao criar conta',
            errors: resource.errors.full_messages
          }, status: :unprocessable_entity
        }
      end
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :g_tipo_usuario_id])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:nome, :g_tipo_usuario_id])
  end

  def after_sign_up_path_for(resource)
    root_path
  end

  def after_inactive_sign_up_path_for(resource)
    root_path
  end

  private

  def sign_up_params
    params.require(:user).permit(:nome, :email, :password, :password_confirmation, :g_tipo_usuario_id)
  end
end
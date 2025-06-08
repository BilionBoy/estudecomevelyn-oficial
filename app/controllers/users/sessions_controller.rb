# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  respond_to :html, :json
  
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    
    respond_to do |format|
      format.html { respond_with resource, location: after_sign_in_path_for(resource) }
      format.json { 
        render json: { 
          success: true, 
          message: 'Login realizado com sucesso!',
          redirect_url: after_sign_in_path_for(resource),
          user: {
            id:    resource.id,
            nome:  resource.nome,
            email: resource.email
          }
        }, status: :ok 
      }
    end
  rescue Warden::NotAuthenticated => e
    respond_to do |format|
      format.html { 
        self.resource = resource_class.new(sign_in_params)
        clean_up_passwords(resource)
        render :new, status: :unprocessable_entity
      }
      format.json { 
        render json: { 
          success: false, 
          error: 'Email ou senha inválidos'
        }, status: :unauthorized
      }
    end
  rescue => e
    respond_to do |format|
      format.html { 
        self.resource = resource_class.new(sign_in_params)
        clean_up_passwords(resource)
        render :new, status: :unprocessable_entity
      }
      format.json { 
        render json: { 
          success: false, 
          error: 'Erro interno do servidor'
        }, status: :internal_server_error
      }
    end
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    
    respond_to do |format|
      format.html { redirect_to after_sign_out_path_for(resource_name) }
      format.json { 
        render json: { 
          success: true, 
          message: 'Logout realizado com sucesso!',
          redirect_url: after_sign_out_path_for(resource_name)
        }, status: :ok 
      }
    end
  end

  protected

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def after_sign_out_path_for(resource_name)
    root_path
  end

  def respond_to_on_destroy
    respond_to do |format|
      format.html { redirect_to after_sign_out_path_for(resource_name) }
      format.json { 
        render json: { 
          success: true, 
          message: 'Logout realizado com sucesso!',
          redirect_url: after_sign_out_path_for(resource_name)
        }, status: :ok 
      }
    end
  end
end
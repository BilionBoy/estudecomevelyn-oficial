# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :html, :json
  
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    
    respond_to do |format|
      format.html { respond_with resource, location: after_sign_in_path_for(resource) }
      format.json { render json: { success: true }, status: :ok }
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  def respond_to_on_destroy
    respond_to do |format|
      format.html { redirect_to after_sign_out_path_for(resource_name) }
      format.json { render json: { success: true }, status: :ok }
    end
  end
end
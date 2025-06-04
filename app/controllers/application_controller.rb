class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pagy::Backend

  layout :set_layout_by_controller

  private

 def set_layout_by_controller
   return "devise_application" if devise_controller?
 
   if current_user&.g_tipo_usuario&.nome == "CLIENTE"
     "cliente"
   elsif controller_path == "store" || controller_path.start_with?("store/")
     "home_application"
   else
     "application"
   end
 end


  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end
end

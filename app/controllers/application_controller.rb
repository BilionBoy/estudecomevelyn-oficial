class ApplicationController < ActionController::Base
  before_action :authenticate_user! # Autentica o usuário antes de qualquer ação
  include Pagy::Backend # Inclui Pagy para uso no Backend

  layout :set_layout_by_controller

  private

  def set_layout_by_controller
    if devise_controller?
      "devise_application"
    elsif controller_name == "store"
      "home_application"
    else
      "application"
    end
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end
end

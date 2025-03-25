class ApplicationController < ActionController::Base
  before_action :authenticate_user! # Autentica o usuário antes de qualquer ação
  include Pagy::Backend # Inclui Pagy para uso no Backend

  before_action :set_layout_by_controller
  private

  def set_layout_by_controller
    if devise_controller?
      self.class.layout "devise_application"
    elsif controller_name == "home"
      self.class.layout "home_application"
    else
      self.class.layout "application"
    end
  end
end

module LayoutByUser
  extend ActiveSupport::Concern

  included do
    layout :set_layout_by_user
  end

  private

  def set_layout_by_user
    return "devise_application" if devise_controller?

    if controller_path.start_with?("store/")
      return "home_application" # layout exclusivo da área da loja
    end

    if current_user
      case current_user.g_tipo_usuario.nome
      when 'ADMIN'
        "application"
      when 'CLIENTE'
        "cliente_application"
      else
        "application"
      end
    end
  end
end

module LayoutByUser
  extend ActiveSupport::Concern

  included do
    layout :set_layout_by_user
  end

  private

  def set_layout_by_user
    return "devise_application" if devise_controller?

    if current_user
      case current_user.g_tipo_usuario.nome
      when 'ADMIN'
        "application"           # layout para admin
      when 'CLIENTE'
        "cliente_application"   # layout para cliente
      else
        "application"           # layout padrão fallback
      end
    else
      # para visitantes não autenticados, pode escolher outro layout, por ex:
      "public_application" # ou "application"
    end
  end
end

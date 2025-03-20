Rails.application.routes.draw do
  resources :g_tipo_usuarios
  root 'admin#index'
  get 'admin/index'

  # Rotas Scaffold

  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end

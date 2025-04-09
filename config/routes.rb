Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  
  get 'g_admin', to: 'g_admin#index', as: :g_admin
  root 'home#index'
  
  # Rotas Scaffold
  resources :users,              only: %i[index show edit update destroy]
  resources :g_tipo_usuarios
  resources :g_categorias
  resources :segmentos
  resources :i_produtos
  resources :i_promocoes

  # Rotas do e-commerce (mais amigáveis)
  get '/papelaria', to: 'home#papelaria', as: :papelaria
  get '/blog',      to: 'home#blog', as: :blog

  # Verificar estado da aplicação
  get 'up' => 'rails/health#show', as: :rails_health_check
end

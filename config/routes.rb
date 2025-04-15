Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  
  # Admin
  get 'g_admin', to: 'g_admin#index', as: :g_admin
  
  # Público / Store
  root 'store#index'
  get '/papelaria', to: 'store#papelaria', as: :papelaria
  get '/blog',      to: 'store#blog',      as: :blog
  get '/cursos',    to: 'store#cursos',    as: :cursos
  
  
  
  # Rotas Scaffold
  resources :users, only: %i[index show edit update destroy]
  resources :g_tipo_usuarios
  resources :g_categorias
  resources :segmentos
  resources :i_produtos
  resources :i_promocoes
  resources :i_promocao_produtos
  
  # Verificar estado da aplicação
  get 'up' => 'rails/health#show', as: :rails_health_check
end

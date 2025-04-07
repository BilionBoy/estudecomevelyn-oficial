Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions'}
  get 'g_admin', to: 'g_admin#index', as: :g_admin
  root 'home#index'
  
  # Rotas Scaffold
  resources :users,              only: %i[index show edit update destroy]
  resources :g_tipo_usuarios
  resources :g_categorias
  resources :segmentos
  resources :i_produtos

  # Rotas do e-commerce
  resources :home, only: [:index] do
    collection do
      get :produtos
      get :cursos
      get :blog
    end
  end
  
  # Verificar estado da aplicação
  get 'up' => 'rails/health#show', as: :rails_health_check
end
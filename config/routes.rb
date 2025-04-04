Rails.application.routes.draw do
  resources :i_produtos
  # Autenticação
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions'}
  # Rotas Scaffold
  resources :users,              only: %i[index show edit update destroy]
  resources :g_tipo_usuarios
  resources :g_categorias
  resources :segmentos
  root 'home#index'

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
Rails.application.routes.draw do
  root 'g_admin#index'

  # Autenticação
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  # Rotas Scaffold
  resources :g_tipo_usuarios

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

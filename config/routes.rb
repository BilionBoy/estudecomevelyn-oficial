Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions',registrations: 'users/registrations'}
  root 'g_admin#index'
  
  # Rotas do e-commerce
  resources :home, only: [:index] do
    collection do
      get :produtos
      get :cursos
      get :blog
    end
  end
  
  # Rotas Scaffold
  resources :g_tipo_usuarios,          only: %i[index show new create edit update destroy]


  # Verificar estado da aplicação
  get 'up' => 'rails/health#show', as: :rails_health_check
end

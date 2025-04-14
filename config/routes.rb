Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  # Admin
  get 'g_admin', to: 'g_admin#index', as: :g_admin

  # Público / Store
  root 'store#index'
  get '/papelaria', to: 'store#papelaria', as: :papelaria
  get '/blog',      to: 'store#blog',      as: :blog
  get '/cursos',    to: 'store#cursos',    as: :cursos

  # Carrinho
  resource :carrinho, only: [:index] do
    post   :add,    to: 'store/carrinho#add',    as: :add
    delete :remove, to: 'store/carrinho#remove', as: :remove
    delete :clear,  to: 'store/carrinho#clear',  as: :clear
  end

  # Rotas Scaffold
  resources :users, only: %i[index show edit update destroy]
  resources :g_tipo_usuarios
  resources :g_categorias
  resources :segmentos
  resources :i_produtos
  resources :i_promocoes

  # Verificar estado da aplicação
  get 'up' => 'rails/health#show', as: :rails_health_check
end

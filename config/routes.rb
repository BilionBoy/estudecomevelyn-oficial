Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  root 'store#index'
  
  namespace :store do
    resource :carrinho, only: [:show], controller: 'carrinho' do
      post   'adicionar',           on: :collection,  to: 'carrinho#adicionar', as: :adicionar_ao_carrinho
      delete 'limpar',              on: :collection,  to: 'carrinho#limpar',    as: :limpar
      delete 'remover/:produto_id', on: :collection,  to: 'carrinho#remover',   as: :remover_item
    end
  end
  
  get 'carrinho',                                     to: 'store/carrinho#show', as: :carrinho
  get '/papelaria',                                   to: 'store#papelaria',     as: :papelaria
  get '/blog',                                        to: 'store#blog',          as: :blog
  get '/cursos',                                      to: 'store#cursos',        as: :cursos
  get 'g_admin',                                      to: 'g_admin#index',       as: :g_admin


  resources :users, only: %i[index show edit update destroy]
  resources :g_tipo_usuarios
  resources :g_categorias
  resources :segmentos
  resources :i_produtos
  resources :i_promocoes
  resources :i_promocao_produtos
  
  get 'up' => 'rails/health#show', as: :rails_health_check
end

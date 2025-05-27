Rails.application.routes.draw do
  resources :g_blog_posts
  # Devise
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  
  # Root
  root 'store#index'
  
  # Store Público
  namespace :store do
    resource :carrinho, only: [:show], controller: 'carrinho' do
      post   :adicionar,            on: :collection, to: 'carrinho#adicionar', as: :adicionar_ao_carrinho
      post   :finalizar_compra,     on: :collection # adiciona essa rota
      delete :limpar,               on: :collection, to: 'carrinho#limpar',    as: :limpar
      delete 'remover/:produto_id', on: :collection, to: 'carrinho#remover',   as: :remover_item
      
    end
    resources :pedidos, only: [:index, :show]
  end
  
  # Links extras da loja
  get 'carrinho',                       to: 'store/carrinho#show',     as: :carrinho
  get 'papelaria',                      to: 'store#papelaria',         as: :papelaria
  get 'blog',                           to: 'store#blog',              as: :blog
  get 'cursos',                         to: 'store#cursos',            as: :cursos
  get 'store/categorias/:slug',         to: 'store#categoria',         as: :store_categoria
  
  get 'checkout/success',               to: 'store/checkouts#success', as: :store_checkout_success
  get 'checkout/cancel',                to: 'store/checkouts#cancel',  as: :store_checkout_cancel
  
  
  # Admin
  get 'g_admin', to: 'g_admin#index', as: :g_admin
  
  # Recursos do Admin
  resources :users, only: %i[index show edit update destroy]
  resources :g_tipo_usuarios
  resources :g_categorias
  resources :segmentos
  resources :i_produtos
  resources :i_cursos
  resources :i_promocoes
  resources :i_promocao_produtos
  resources :g_blog_categorias

  # Robots.txt e Sitemap
  get '/robots.txt',  to: proc { |env| [200, { 'Content-Type' => 'text/plain' }, [File.read(Rails.root.join('public', 'robots.txt'))]] }
  get '/sitemap.xml', to: proc { |env| [200, { 'Content-Type' => 'application/xml' }, [File.read(Rails.root.join('public', 'sitemap.xml'))]] }

  # Health Check
  get 'up', to: 'rails/health#show', as: :rails_health_check
end

class Store::CheckoutsController < ApplicationController
  def new
    @carrinho = current_user.carrinho_ativo
  end
end

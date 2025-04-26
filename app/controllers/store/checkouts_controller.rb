class Store::CheckoutsController < ApplicationController
  def new
    @carrinho = current_user.carrinho_atual
  end
end

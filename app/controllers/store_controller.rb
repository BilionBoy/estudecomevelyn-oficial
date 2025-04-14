class StoreController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :papelaria, :cursos, :blog]

  def index
    @g_categorias = GCategoria.all
    if params[:categoria].present?
      categoria = GCategoria.find_by(slug: params[:categoria])
      if categoria.present?
        @pagy, @i_produtos = pagy(
          categoria.i_produtos.where(status: :ativo).order(created_at: :desc),
          items: 6
        )
      else
        @i_produtos = []
      end
    else
      @pagy, @i_produtos = pagy(
        IProduto.where(status: :ativo).order(created_at: :desc),
        items: 6
      )
    end
  end

  def papelaria
    @g_categorias = GCategoria.order(:nome)
  
    if params[:categoria].present?
      categoria = GCategoria.find_by(slug: params[:categoria])
      if categoria.present?
        @pagy, @produtos = pagy(
          categoria.i_produtos.where(status: :ativo).order(created_at: :desc),
          items: 6
        )
      else
        @produtos = []
      end
    else
      @pagy, @produtos = pagy(
        IProduto.where(status: :ativo).order(created_at: :desc),
        items: 6
      )
    end
  
    respond_to do |format|
      format.html
      format.js
    end
  end
  def cursos
  end

  def blog
  end
end

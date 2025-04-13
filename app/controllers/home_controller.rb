class HomeController < ApplicationController
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
    @produtos = IProduto.where(status: 1).order(created_at: :desc)
    @g_categorias = GCategoria.order(:nome) # Não é necessário incluir :foto_categoria
  end
  
  
  

  def cursos
  end

  def blog
  end
end

class StoreController < ApplicationController
  layout "home_application"
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
    segmento_cursos = Segmento.find_by(nome: "Cursos")
    @g_categorias = segmento_cursos.present? ? segmento_cursos.g_categorias.order(:nome) : []
  
    # Para cada categoria, buscamos os cursos
    if params[:categoria].present?
      categoria = GCategoria.find_by(slug: params[:categoria])
      if categoria.present?
        @pagy, @cursos = pagy(
          categoria.i_cursos.where(status: :ativo).order(created_at: :desc),
          items: 6
        )
      else
        @cursos = []
      end
    else
      @pagy, @cursos = pagy(
        ICurso.where(status: :ativo).order(created_at: :desc),
        items: 6
      )
    end
  
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  

  def blog
  end
end

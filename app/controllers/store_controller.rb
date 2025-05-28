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
  @g_categorias = GCategoria.where.not(id: Segmento.find_by(nome: "Cursos")&.g_categorias&.pluck(:id)).order(:nome)

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
    # Buscar categorias de blog
    @blog_categorias = GBlogCategoria.all.order(:descricao)
    # Buscar posts com filtros
    posts_query = GBlogPost.where('data_publicacao <= ?', Time.current)
    # Filtro por categoria
    if params[:categoria].present?
      categoria = GBlogCategoria.find_by(slug: params[:categoria])
      posts_query = posts_query.where(g_blog_categoria: categoria) if categoria.present?
    end
    # Filtro por busca
    if params[:busca].present?
      posts_query = posts_query.where(
        "titulo ILIKE ? OR resumo ILIKE ? OR conteudo ILIKE ?", 
        "%#{params[:busca]}%", 
        "%#{params[:busca]}%", 
        "%#{params[:busca]}%"
      )
    end
    # Filtro por tag (se você implementar tags)
    if params[:tag].present?
      # Implementar filtro por tag quando necessário
    end
    # Paginação
    @pagy, @blog_posts = pagy(
      posts_query.order(data_publicacao: :desc),
      items: 6
    )
    # Posts populares (últimos 3 mais recentes ou por visualizações se implementar)
    @posts_populares = GBlogPost.where('data_publicacao <= ?', Time.current)
                                .order(data_publicacao: :desc)
                                .limit(3)
    
    # Tags (se você implementar)
    @tags = [] # Implementar quando necessário
    
    respond_to do |format|
      format.html
      format.js
    end
  end

end

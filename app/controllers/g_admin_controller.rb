class GAdminController < ApplicationController
  def index
    inicio_do_mes = Time.zone.now.beginning_of_month

    @total_usuarios       = User.count
    @total_produtos       = IProduto.count
    @total_cursos         = ICurso.count
    @total_segmentos      = Segmento.count
    @total_categorias     = GCategoria.count
    @total_pedidos        = IPedido.count
    @total_blog_posts     = GBlogPost.count

    @vendas_mes           = IPedido.confirmados.where('created_at >= ?', inicio_do_mes).sum(:total)
    @novos_usuarios_mes   = User.where('created_at >= ?', inicio_do_mes).count
    @produtos_vendidos_mes = IItemPedido.joins(:i_pedido).where('i_pedidos.created_at >= ?', inicio_do_mes).sum(:quantidade)

    @pedidos_recentes     = IPedido.includes(:user, itens_pedidos: :i_produto).order(created_at: :desc).limit(5)

    @produtos_populares   = IProduto
                              .joins(:i_itens_pedidos)
                              .group('i_produtos.id, i_produtos.nome')
                              .order('SUM(i_itens_pedidos.quantidade) DESC')
                              .limit(5)
                              .pluck('i_produtos.nome', 'SUM(i_itens_pedidos.quantidade)')
  end

  def meus_pedidos
    @pagy, @pedidos = pagy(
      current_user.i_pedidos
                  .includes(i_itens_pedidos: :i_produto)
                  .order(created_at: :desc),
      items: 10
    )

    # Estatísticas do cliente
    @total_pedidos = current_user.i_pedidos.count
    @total_gasto = current_user.i_pedidos.confirmados.sum(:total)
    @pedido_recente = current_user.i_pedidos.order(created_at: :desc).first
    @produtos_favoritos = current_user.i_pedidos
                                     .joins(i_itens_pedidos: :i_produto)
                                     .group('i_produtos.nome')
                                     .order(Arel.sql('COUNT(*) DESC'))
                                     .limit(3)
                                     .count
  end

def meus_produtos
  @produtos_comprados = IProduto.joins(i_itens_pedidos: { i_pedido: :usuario })
                                .where(i_pedidos: { usuario_id: current_user.id, status: 'confirmado' })
                                .distinct
                                .includes(:g_categoria, :imagem_attachment, :arquivo_attachment)

  @total_produtos = @produtos_comprados.count
  @total_downloads = 0 # contador futuro
  @produtos_com_arquivo = @produtos_comprados.joins(:arquivo_attachment).count

end



  def download_produto
    produto = IProduto.find(params[:id])
    
    # Verificar se o usuário comprou este produto
    pedido_confirmado = current_user.i_pedidos
                                   .confirmados
                                   .joins(:i_itens_pedidos)
                                   .where(i_itens_pedidos: { i_produto_id: produto.id })
                                   .exists?

    if pedido_confirmado && produto.arquivo.attached?
      # Aqui você pode implementar um log de download se necessário
      redirect_to rails_blob_path(produto.arquivo, disposition: "attachment")
    else
      redirect_to meus_produtos_path, alert: 'Produto não encontrado ou você não tem permissão para baixá-lo.'
    end
  end

  def pedido_detalhes
    @pedido = current_user.i_pedidos.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to meus_pedidos_path, alert: 'Pedido não encontrado.'
  end
end
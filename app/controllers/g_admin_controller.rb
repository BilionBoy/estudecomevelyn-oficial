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
end

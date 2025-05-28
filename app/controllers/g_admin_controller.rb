class GAdminController < ApplicationController
  def index
    # Contadores baseados no schema real
    @total_usuarios = User.count
    @total_produtos = IProduto.count
    @total_cursos = ICurso.count
    @total_segmentos = Segmento.count
    @total_categorias = GCategoria.count
    @total_pedidos = IPedido.count
    @total_blog_posts = GBlogPost.count
    
    # Vendas do mês atual
    @vendas_mes = IPedido.where('created_at >= ?', Date.current.beginning_of_month).sum(:total)
    
    # Novos usuários do mês
    @novos_usuarios_mes = User.where('created_at >= ?', Date.current.beginning_of_month).count
    
    # Produtos vendidos (através dos itens de pedidos)
    @produtos_vendidos_mes = IItemPedido.joins(:i_pedido)
                                        .where('i_pedidos.created_at >= ?', Date.current.beginning_of_month)
                                        .sum(:quantidade)
    
    # Pedidos recentes com dados relacionados
    @pedidos_recentes = IPedido.includes(:user, itens_pedidos: :i_produto)
                              .order(created_at: :desc)
                              .limit(5)
    
    # Produtos mais vendidos
    @produtos_populares = IProduto.joins(:i_itens_pedidos)
                                 .group('i_produtos.id, i_produtos.nome')
                                 .order('SUM(i_itens_pedidos.quantidade) DESC')
                                 .limit(5)
                                 .pluck('i_produtos.nome', 'SUM(i_itens_pedidos.quantidade)')
  end
end

# config/initializers/inflections.rb

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular 'g_usuario',           'g_usuarios'
  inflect.irregular 'g_tipo_usuario',      'g_tipo_usuarios'
  inflect.irregular 'segmento',            'segmentos'
  inflect.irregular 'g_categoria',         'g_categorias'
  inflect.irregular 'i_produto',           'i_produtos'
  inflect.irregular 'i_promocao',          'i_promocoes'
  inflect.irregular 'i_promocao_produto',  'i_promocao_produtos'
  inflect.irregular 'i_carrinho',          'i_carrinhos'
  inflect.irregular 'i_item_carrinho',     'i_itens_carrinhos'
  inflect.irregular 'i_pedido',            'i_pedidos'

end


# config/initializers/inflections.rb

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular 'g_usuario',      'g_usuarios'
  inflect.irregular 'g_tipo_usuario', 'g_tipo_usuarios'
  inflect.irregular 'segmento',        'segmentos'
end


json.extract! g_blog_post, :id, :titulo, :resumo, :conteudo, :data_publicacao, :g_blog_categoria_id, :created_at, :updated_at
json.url g_blog_post_url(g_blog_post, format: :json)

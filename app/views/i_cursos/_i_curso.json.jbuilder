json.extract! i_curso, :id, :nome, :slug, :descricao, :preco, :g_categoria_id, :url_externa, :status, :created_by, :updated_by, :created_at, :updated_at
json.url i_curso_url(i_curso, format: :json)

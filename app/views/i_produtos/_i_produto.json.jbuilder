json.extract! i_produto, :id, :nome, :slug, :descricao, :preco, :g_categoria_id, :arquivo_url, :imagem_url, :status, :deleted_at, :created_by, :updated_by, :created_at, :updated_at
json.url i_produto_url(i_produto, format: :json)

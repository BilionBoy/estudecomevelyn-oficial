json.extract! g_usuario, :id, :nome, :email, :password_digest, :tipo_usuario_id, :created_at, :updated_at
json.url g_usuario_url(g_usuario, format: :json)

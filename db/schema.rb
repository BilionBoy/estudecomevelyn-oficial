# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_05_27_170155) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "g_blog_categorias", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_blog_posts", force: :cascade do |t|
    t.string "titulo", null: false
    t.string "resumo", null: false
    t.text "conteudo", null: false
    t.datetime "data_publicacao", null: false
    t.bigint "g_blog_categoria_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["g_blog_categoria_id"], name: "index_g_blog_posts_on_g_blog_categoria_id"
  end

  create_table "g_categorias", force: :cascade do |t|
    t.string "nome", null: false
    t.string "slug", null: false
    t.text "descricao"
    t.bigint "segmento_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["segmento_id"], name: "index_g_categorias_on_segmento_id"
    t.index ["slug", "segmento_id"], name: "index_g_categorias_on_slug_and_segmento_id", unique: true
  end

  create_table "g_tipo_usuarios", force: :cascade do |t|
    t.string "nome", null: false
    t.text "descricao"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "i_carrinhos", force: :cascade do |t|
    t.bigint "usuario_id", null: false
    t.string "status"
    t.datetime "criado_em"
    t.datetime "atualizado_em"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_i_carrinhos_on_usuario_id"
  end

  create_table "i_cupons", force: :cascade do |t|
    t.string "codigo", null: false
    t.string "tipo_desconto"
    t.decimal "valor", precision: 10, scale: 2
    t.datetime "validade"
    t.boolean "status", default: true
    t.datetime "criado_em"
    t.datetime "atualizado_em"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["codigo"], name: "index_cupons_on_codigo", unique: true
  end

  create_table "i_cursos", force: :cascade do |t|
    t.string "nome"
    t.string "slug"
    t.text "descricao"
    t.decimal "preco", precision: 10, scale: 2
    t.bigint "g_categoria_id", null: false
    t.string "url_externa"
    t.string "status"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["g_categoria_id"], name: "index_i_cursos_on_g_categoria_id"
    t.index ["slug"], name: "index_i_cursos_on_slug", unique: true
  end

  create_table "i_itens_carrinhos", force: :cascade do |t|
    t.bigint "i_carrinho_id", null: false
    t.bigint "i_produto_id", null: false
    t.integer "quantidade"
    t.decimal "preco_unitario", precision: 10, scale: 2
    t.decimal "subtotal", precision: 10, scale: 2
    t.datetime "criado_em"
    t.datetime "atualizado_em"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["i_carrinho_id", "i_produto_id"], name: "index_itens_carrinho_unique", unique: true
    t.index ["i_carrinho_id"], name: "index_i_itens_carrinhos_on_i_carrinho_id"
    t.index ["i_produto_id"], name: "index_i_itens_carrinhos_on_i_produto_id"
  end

  create_table "i_itens_pedidos", force: :cascade do |t|
    t.bigint "i_pedido_id", null: false
    t.bigint "i_produto_id", null: false
    t.integer "quantidade"
    t.decimal "preco_unitario", precision: 10, scale: 2
    t.decimal "subtotal", precision: 10, scale: 2
    t.datetime "criado_em"
    t.datetime "atualizado_em"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["i_pedido_id", "i_produto_id"], name: "index_itens_pedidos_unique", unique: true
    t.index ["i_pedido_id"], name: "index_i_itens_pedidos_on_i_pedido_id"
    t.index ["i_produto_id"], name: "index_i_itens_pedidos_on_i_produto_id"
  end

  create_table "i_pedidos", force: :cascade do |t|
    t.bigint "usuario_id", null: false
    t.decimal "total", precision: 10, scale: 2
    t.integer "status", default: 0, null: false
    t.datetime "criado_em"
    t.datetime "atualizado_em"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_i_pedidos_on_usuario_id"
  end

  create_table "i_produtos", force: :cascade do |t|
    t.string "nome", null: false
    t.string "slug", null: false
    t.text "descricao"
    t.decimal "preco", precision: 10, scale: 2
    t.bigint "g_categoria_id", null: false
    t.integer "status", default: 1, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["g_categoria_id"], name: "index_i_produtos_on_g_categoria_id"
    t.index ["slug"], name: "index_i_produtos_on_slug", unique: true
  end

  create_table "i_promocao_produtos", force: :cascade do |t|
    t.bigint "i_promocao_id"
    t.bigint "i_produto_id"
    t.decimal "preco_promocional", precision: 10, scale: 2
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["i_produto_id"], name: "index_i_promocao_produtos_on_i_produto_id"
    t.index ["i_promocao_id", "i_produto_id"], name: "index_promocao_produto_unique", unique: true
    t.index ["i_promocao_id"], name: "index_i_promocao_produtos_on_i_promocao_id"
  end

  create_table "i_promocoes", force: :cascade do |t|
    t.string "nome"
    t.text "descricao"
    t.boolean "ativo"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "segmentos", force: :cascade do |t|
    t.string "nome"
    t.text "descricao"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "nome", null: false
    t.string "email", default: "", null: false
    t.bigint "g_tipo_usuario_id", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["g_tipo_usuario_id"], name: "index_users_on_g_tipo_usuario_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "g_blog_posts", "g_blog_categorias"
  add_foreign_key "g_categorias", "segmentos"
  add_foreign_key "i_carrinhos", "users", column: "usuario_id"
  add_foreign_key "i_cursos", "g_categorias"
  add_foreign_key "i_itens_carrinhos", "i_carrinhos"
  add_foreign_key "i_itens_carrinhos", "i_produtos"
  add_foreign_key "i_itens_pedidos", "i_pedidos"
  add_foreign_key "i_itens_pedidos", "i_produtos"
  add_foreign_key "i_pedidos", "users", column: "usuario_id"
  add_foreign_key "i_produtos", "g_categorias"
  add_foreign_key "i_promocao_produtos", "i_produtos"
  add_foreign_key "i_promocao_produtos", "i_promocoes"
  add_foreign_key "users", "g_tipo_usuarios"
end

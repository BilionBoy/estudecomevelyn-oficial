# frozen_string_literal: true

class AddFotoCategoriaToGCategorias < ActiveRecord::Migration[7.2]
  def change
    add_reference :g_categorias, :foto_categoria, foreign_key: { to_table: :active_storage_attachments }
  end
end


# frozen_string_literal: true

class CreateGCategorias < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:g_categorias)
      create_table :g_categorias do |t|
        t.string     :nome, null: false
        t.string     :slug, null: false
        t.text       :descricao
        t.references :segmento, foreign_key: true
        t.datetime   :deleted_at
        t.timestamps
      end

      add_index :g_categorias, [:slug, :segmento_id], unique: true
    end
  end

  def down
    drop_table :g_categorias if table_exists?(:g_categorias)
  end
end

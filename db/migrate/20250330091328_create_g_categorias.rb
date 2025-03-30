# frozen_string_literal: true

class CreateGCategorias < ActiveRecord::Migration[7.2]
  def up
    create_table :g_categorias do |t|
      t.string     :nome, null: false
      t.string     :slug, null: false
      t.text       :descricao
      t.references :segmento, foreign_key: true
      t.datetime   :deleted_at
      t.string     :created_by
      t.string     :updated_by
      t.timestamps
    end

    add_index :g_categorias, :slug, unique: true
  end

  def down
    drop_table :g_categorias
  end
end

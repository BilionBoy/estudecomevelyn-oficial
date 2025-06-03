# frozen_string_literal: true

class CreateIProdutos < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:i_produtos)
      create_table :i_produtos do |t|
        t.string     :nome,     null: false
        t.string     :slug,     null: false
        t.text       :descricao
        t.decimal    :preco, precision: 10, scale: 2
        t.references :g_categoria, null: false, foreign_key: true
        t.string     :arquivo_url
        t.string     :imagem_url
        t.integer    :status, default: 1, null: false  
        t.datetime   :deleted_at
        t.timestamps
      end

      add_index :i_produtos, :slug, unique: true
    end
  end

  def down
    drop_table :i_produtos if table_exists?(:i_produtos)
  end
end

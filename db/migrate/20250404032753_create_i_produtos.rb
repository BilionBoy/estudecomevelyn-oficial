# frozen_string_literal: true

class CreateIProdutos < ActiveRecord::Migration[7.2]
  def up
    create_table :i_produtos do |t|
      t.string     :nome
      t.string     :slug
      t.text       :descricao
      t.decimal    :preco, precision: 10, scale:2
      t.references :g_categoria, null: false, foreign_key: true
      t.string     :arquivo_url
      t.string     :imagem_url
      t.string     :status
      t.string     :created_by
      t.string     :updated_by
      t.datetime :deleted_at
      t.timestamps

    end
    
    add_index :i_produtos, :slug, unique: true
  end

  def down
    drop_table :i_produtos
  end
end

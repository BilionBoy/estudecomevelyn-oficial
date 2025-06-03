# frozen_string_literal: true

class CreateIPromocaoProdutos < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:i_promocao_produtos)
      create_table :i_promocao_produtos do |t|
        t.references :i_promocao, foreign_key: true
        t.references :i_produto,  foreign_key: true
        t.decimal    :preco_promocional, precision: 10, scale: 2
        t.datetime   :deleted_at
        t.timestamps
      end

      add_index :i_promocao_produtos, [:i_promocao_id, :i_produto_id], unique: true, name: 'index_promocao_produto_unique'
    end
  end

  def down
    drop_table :i_promocao_produtos if table_exists?(:i_promocao_produtos)
  end
end

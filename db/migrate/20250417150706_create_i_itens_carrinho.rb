# frozen_string_literal: true

class CreateIItensCarrinho < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:i_itens_carrinhos)
      create_table :i_itens_carrinhos do |t|
        t.references :i_carrinho, null: false, foreign_key: true
        t.references :i_produto,  null: false, foreign_key: true
        t.integer    :quantidade
        t.decimal    :preco_unitario, precision: 10, scale: 2
        t.decimal    :subtotal,       precision: 10, scale: 2
        t.datetime   :criado_em
        t.datetime   :atualizado_em
        t.datetime   :deleted_at
        t.timestamps
      end

      # 🔒 Índice único opcional para garantir que não haja produtos duplicados no mesmo carrinho
      add_index :i_itens_carrinhos, [:i_carrinho_id, :i_produto_id], unique: true, name: 'index_itens_carrinho_unique'
    end
  end

  def down
    drop_table :i_itens_carrinhos if table_exists?(:i_itens_carrinhos)
  end
end

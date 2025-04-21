# frozen_string_literal: true

class CreateIItensPedidos < ActiveRecord::Migration[7.2]
  def up
    create_table :i_itens_pedidos do |t|
      t.references :i_pedido,       null: false, foreign_key: true
      t.references :i_produto,      null: false, foreign_key: true
      t.integer    :quantidade
      t.decimal    :preco_unitario, precision: 10, scale: 2
      t.decimal    :subtotal,       precision: 10, scale: 2
      t.datetime   :criado_em
      t.datetime   :atualizado_em
      t.string :created_by
      t.string :updated_by
      t.datetime :deleted_at
      t.timestamps
    end
  end

  def down
    drop_table :i_itens_pedidos
  end
end

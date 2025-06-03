# frozen_string_literal: true

class CreateIPedidos < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:i_pedidos)
      create_table :i_pedidos do |t|
        t.references :usuario, null: false, foreign_key: { to_table: :users }
        t.decimal    :total,   precision: 10, scale: 2
        t.string     :status
        t.datetime   :criado_em
        t.datetime   :atualizado_em
        t.datetime   :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :i_pedidos if table_exists?(:i_pedidos)
  end
end

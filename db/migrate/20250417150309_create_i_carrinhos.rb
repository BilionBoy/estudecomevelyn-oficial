# frozen_string_literal: true

class CreateICarrinhos < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:i_carrinhos)
      create_table :i_carrinhos do |t|
        t.references :usuario, null: false, foreign_key: { to_table: :users }
        t.string     :status
        t.datetime   :criado_em
        t.datetime   :atualizado_em
        t.datetime   :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :i_carrinhos if table_exists?(:i_carrinhos)
  end
end

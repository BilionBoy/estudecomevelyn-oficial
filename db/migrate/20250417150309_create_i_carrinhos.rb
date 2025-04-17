# frozen_string_literal: true

class CreateICarrinhos < ActiveRecord::Migration[7.2]
  def up
    create_table :i_carrinhos do |t|
      t.references :usuario, null: false, foreign_key: { to_table: :users }
      t.string     :status
      t.datetime   :criado_em
      t.datetime   :atualizado_em
      t.string     :created_by
      t.string     :updated_by
      t.datetime   :deleted_at
      t.timestamps
    end
  end

  def down
    drop_table :i_carrinhos
  end
end

# frozen_string_literal: true

class CreateICupons < ActiveRecord::Migration[7.2]
  def up
    create_table :i_cupons do |t|
      t.string   :codigo, null: false
      t.string   :tipo_desconto
      t.decimal  :valor, precision: 10, scale: 2
      t.datetime :validade
      t.boolean  :status
      t.datetime :criado_em
      t.datetime :atualizado_em
      t.string   :created_by
      t.string   :updated_by
      t.datetime :deleted_at
      t.timestamps
    end
  end

  def down
    drop_table :i_cupons
  end
end

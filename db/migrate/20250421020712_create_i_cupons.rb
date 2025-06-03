# frozen_string_literal: true

class CreateICupons < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:i_cupons)
      create_table :i_cupons do |t|
        t.string   :codigo, null: false
        t.string   :tipo_desconto
        t.decimal  :valor, precision: 10, scale: 2
        t.datetime :validade
        t.boolean  :status, default: true
        t.datetime :criado_em
        t.datetime :atualizado_em
        t.datetime :deleted_at
        t.timestamps
      end

      # 🔐 Índice único para garantir códigos de cupons únicos
      add_index :i_cupons, :codigo, unique: true, name: 'index_cupons_on_codigo'
    end
  end

  def down
    drop_table :i_cupons if table_exists?(:i_cupons)
  end
end

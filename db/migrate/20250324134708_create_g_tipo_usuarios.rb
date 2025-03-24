# frozen_string_literal: true

class CreateGTipoUsuarios < ActiveRecord::Migration[7.2]
  def up
    create_table :g_tipo_usuarios do |t|
      t.string   :nome, null: false
      t.text     :descricao
      t.string   :created_by
      t.string   :updated_by
      t.datetime :deleted_at
      t.timestamps
    end
  end

  def down
    drop_table :g_tipo_usuarios
  end
end

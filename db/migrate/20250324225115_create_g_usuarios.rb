# frozen_string_literal: true

class CreateGUsuarios < ActiveRecord::Migration[7.2]
  def up
    create_table :g_usuarios do |t|
      t.string     :nome
      t.string     :email, null: false
      t.string     :password_digest
      t.references :tipo_usuario
      t.string     :created_by
      t.string     :updated_by
      t.datetime   :deleted_at
      t.timestamps
    end
  end

  def down
    drop_table :g_usuarios
  end
end

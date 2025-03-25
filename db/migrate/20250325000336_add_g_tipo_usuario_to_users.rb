# frozen_string_literal: true

class AddGTipoUsuarioToUsers < ActiveRecord::Migration[7.2]
  def up
    # Adiciona a coluna g_tipo_usuario_id à tabela users
    add_reference :users, :g_tipo_usuario, foreign_key: { to_table: :g_tipo_usuarios }
  end

  def down
    # Remove a coluna g_tipo_usuario_id da tabela users
    remove_reference :users, :g_tipo_usuario, foreign_key: true
  end
end

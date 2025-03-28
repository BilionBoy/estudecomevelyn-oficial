# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      ## Informações do Cliente
      t.string :nome,               null: false
      t.string :email,              null: false, default: ""
      t.references :g_tipo_usuario, null: false, foreign_key: { to_table: :g_tipo_usuarios }

      ## Devise Autenticação
      t.string :encrypted_password, null: false, default: ""

      ## Recuperação de Senha
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Lembrete de Sessão
      t.datetime :remember_created_at

      ## Timestamps
      t.timestamps null: false
    end

    # Índices para melhorar a performance
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end

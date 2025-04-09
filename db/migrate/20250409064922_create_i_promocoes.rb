# frozen_string_literal: true

class CreateIPromocoes < ActiveRecord::Migration[7.2]
  def up
    create_table :i_promocoes do |t|
      t.string :nome
      t.text :descricao
      t.boolean :ativo
      t.string :slug
          
      t.string :created_by
      t.string :updated_by
      t.datetime :deleted_at
      t.timestamps
    end
  end

  def down
    drop_table :i_promocoes
  end
end

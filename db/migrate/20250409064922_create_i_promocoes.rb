# frozen_string_literal: true

class CreateIPromocoes < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:i_promocoes)
      create_table :i_promocoes do |t|
        t.string   :nome
        t.text     :descricao
        t.boolean  :ativo
        t.string   :slug
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :i_promocoes if table_exists?(:i_promocoes)
  end
end

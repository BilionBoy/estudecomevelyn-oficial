# frozen_string_literal: true

class CreateSegmentos < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:segmentos)
      create_table :segmentos do |t|
        t.string   :nome
        t.text     :descricao
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :segmentos if table_exists?(:segmentos)
  end
end

# frozen_string_literal: true

class CreateSegmentos < ActiveRecord::Migration[7.2]
  def up
    create_table :segmentos do |t|
      t.string   :nome
      t.text     :descricao
      t.string   :created_by
      t.string   :updated_by
      t.datetime :deleted_at
      t.timestamps
    end
  end

  def down
    drop_table :segmentos
  end
end

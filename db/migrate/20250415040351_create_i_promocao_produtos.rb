# frozen_string_literal: true

class CreateIPromocaoProdutos < ActiveRecord::Migration[7.2]
  def up
    create_table :i_promocao_produtos do |t|
      t.references :i_promocao, foreign_key: true
      t.references :i_produto,  foreign_key: true
      t.decimal    :preco_promocional, precision: 10, scale: 2
      t.string     :created_by
      t.string     :updated_by
      t.datetime   :deleted_at
      t.timestamps
    end
  end

  def down
    drop_table :i_promocao_produtos
  end
end

class ChangeStatusToIntegerInIProdutos < ActiveRecord::Migration[7.2]
  def up
    return unless column_exists?(:i_produtos, :status)

    # Remove default antigo (se houver), altera para integer com default novo
    change_column :i_produtos, :status, :integer, using: 'status::integer', default: 1
  end

  def down
    return unless column_exists?(:i_produtos, :status)

    # Reverte para string (sem default)
    change_column :i_produtos, :status, :string
  end
end

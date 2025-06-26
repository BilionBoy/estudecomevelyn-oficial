# frozen_string_literal: true

class AddCpfAndAsaasCustomerIdToUsers < ActiveRecord::Migration[7.2]
  def up
    unless column_exists?(:users, :cpf)
      add_column :users, :cpf, :string
    end

    unless column_exists?(:users, :asaas_customer_id)
      add_column :users, :asaas_customer_id, :string
    end

    unless index_exists?(:users, :cpf)
      add_index :users, :cpf, unique: true
    end

    unless index_exists?(:users, :asaas_customer_id)
      add_index :users, :asaas_customer_id, unique: true
    end
  end

  def down
    if index_exists?(:users, :asaas_customer_id)
      remove_index :users, :asaas_customer_id
    end

    if index_exists?(:users, :cpf)
      remove_index :users, :cpf
    end

    if column_exists?(:users, :asaas_customer_id)
      remove_column :users, :asaas_customer_id
    end

    if column_exists?(:users, :cpf)
      remove_column :users, :cpf
    end
  end
end

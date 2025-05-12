# frozen_string_literal: true
class IItemPedido < ApplicationRecord
  belongs_to :i_pedido
  belongs_to :i_produto

  validates :quantidade, numericality: { only_integer: true, greater_than: 0 }
  validates :preco_unitario, numericality: { greater_than: 0 }

  before_save :calcular_subtotal

  private

  def calcular_subtotal
    return unless preco_unitario && quantidade

    self.subtotal = (preco_unitario * quantidade).round(2)
  
  end
end

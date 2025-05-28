# frozen_string_literal: true
class IPedido < ApplicationRecord
  belongs_to :usuario, class_name: 'User'
  has_many   :i_itens_pedidos
  has_many   :i_produtos, through: :i_itens_pedidos
  scope :confirmados, -> { where(status: 'confirmado') }

  validates :total, numericality: { greater_than: 0 }

  enum status: { aguardando_pagamento: 0, pago: 1, cancelado: 2 }

  def calcular_total
    i_itens_pedidos.sum(:subtotal)
  end
end


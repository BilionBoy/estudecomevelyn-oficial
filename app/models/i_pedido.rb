# frozen_string_literal: true
class IPedido < ApplicationRecord
  belongs_to :usuario, class_name: 'User'
  has_many   :i_itens_pedidos
  has_many   :i_produtos, through: :i_itens_pedidos
  
  # Ajustado para usar o status do enum
  scope :confirmados, -> { where(status: :confirmado) }

  validates :total, numericality: { greater_than: 0 }

  # Inclui 'confirmado' no enum para que seja válido e consistente
  enum status: { aguardando_pagamento: 0, confirmado: 1, cancelado: 2 }

  def calcular_total
    i_itens_pedidos.sum(:subtotal)
  end
end

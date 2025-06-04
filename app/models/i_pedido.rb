# frozen_string_literal: true
class IPedido < ApplicationRecord
  belongs_to :usuario, class_name: 'User'
  has_many   :i_itens_pedidos
  has_many   :i_produtos, through: :i_itens_pedidos
  
  scope :confirmados,          -> { where(status: :confirmado) }
  scope :aguardando_pagamento, -> { where(status: :aguardando_pagamento) }
  scope :cancelados,           -> { where(status: :cancelado) }

  validates :total, numericality: { greater_than: 0 }

  enum status: { aguardando_pagamento: 0, confirmado: 1, cancelado: 2 }

  def calcular_total
    i_itens_pedidos.sum(:subtotal)
  end

  def processando?
    aguardando_pagamento?
  end

  def finalizado?
    confirmado?
  end
end

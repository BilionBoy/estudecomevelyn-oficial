class IItemCarrinho < ApplicationRecord
  belongs_to :i_carrinho
  belongs_to :i_produto

  validates :quantidade, numericality: { greater_than_or_equal_to: 1 }
  validates :preco_unitario, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
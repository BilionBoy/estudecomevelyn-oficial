class IItemCarrinho < ApplicationRecord
  belongs_to :i_carrinho
  belongs_to :i_produto

  validates :quantidade,numericality: {  only_integer: true, greater_than: 0, message: "deve ser um número inteiro maior que zero"}

  validates :preco_unitario, numericality: { greater_than: 0,message: "deve ser maior que zero"}

  before_validation :set_preco_from_product

  private

  def set_preco_from_product
    if i_produto && preco_unitario.nil?
      self.preco_unitario = i_produto.preco
    end
  end

  def calcular_subtotal
    return unless preco_unitario && quantity
    
    self.subtotal = (preco_unitario * quantity).round(2)
  end
end
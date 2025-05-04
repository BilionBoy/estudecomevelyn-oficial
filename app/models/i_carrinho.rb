class ICarrinho < ApplicationRecord
  belongs_to :usuario, class_name: 'User'
  has_many   :i_itens_carrinhos

  validates :status, inclusion: { in: %w[ativo inativo cancelado] }

  def adicionar_item(produto)
    validar_produto!(produto)
    return i_itens_carrinhos.find_by(i_produto_id: produto.id) if item_presente?(produto)
    i_itens_carrinhos.create!(i_produto: produto, quantidade: 1, preco_unitario: produto.preco.to_d)
  end

  def item_presente?(produto)
    i_itens_carrinhos.exists?(i_produto_id: produto.id)
  end

  def total
    i_itens_carrinhos.sum(:subtotal)
  end

  def total_itens
    i_itens_carrinhos.count
  end

  private

  def validar_produto!(produto)
    raise ArgumentError, "Produto inválido" unless produto.is_a?(IProduto)
    raise ArgumentError, "Produto sem preço válido" if produto.preco.blank? || produto.preco <= 0
  end
end

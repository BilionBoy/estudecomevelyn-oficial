class ICarrinho < ApplicationRecord
  belongs_to :usuario, class_name: 'User'
  has_many   :i_itens_carrinhos

  validates :status, inclusion: { in: %w[ativo inativo cancelado] }

  
  def adicionar_item(produto, quantidade)
    item = i_itens_carrinhos.find_or_initialize_by(i_produto: produto)
    item.quantidade += quantidade
    item.preco_unitario = produto.preco
    item.subtotal = item.quantidade * item.preco_unitario
    item.save
  end

  def total
    i_itens_carrinhos.sum(:subtotal)
  end
  
end

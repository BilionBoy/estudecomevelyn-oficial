class ICarrinho < ApplicationRecord
  belongs_to :usuario, class_name: 'User'
  has_many   :i_itens_carrinhos

  validates :status, inclusion: { in: %w[ativo inativo cancelado] }

  
  def adicionar_item(produto, quantidade)
    raise ArgumentError, "Produto inválido" unless produto.is_a?(IProduto)
    raise ArgumentError, "Produto sem preço válido" if produto.preco.blank? || produto.preco <= 0
  
    quantidade = quantidade.to_i
    raise ArgumentError, "Quantidade inválida" if quantidade < 1
  
    item = i_itens_carrinhos.find_or_initialize_by(i_produto: produto)
    item.quantidade = (item.quantidade || 0) + quantidade
    item.preco_unitario = produto.preco.to_d
    item.subtotal = (item.quantidade * item.preco_unitario).round(2)
    item.save!
    
    item
  rescue => e
    Rails.logger.error "Falha ao adicionar item: #{e.message}\n#{e.backtrace.join("\n")}"
    raise
  end

  def total
    i_itens_carrinhos.sum(:subtotal)
  end
  
end

class IProduto < ApplicationRecord
  extend FriendlyId
  friendly_id :nome, use: :slugged

  before_validation :set_default_preco

  has_one_attached  :imagem
  has_many_attached :arquivo
  has_many          :i_promocoes, through: :i_promocao_produtos
  has_many          :i_promocao_produtos 
  has_many          :i_itens_carrinhos
  has_many          :i_itens_pedidos
  belongs_to        :g_categoria

  attr_accessor :remove_imagem

  enum status: { inativo: 0, ativo: 1 }

  validates :nome,        presence: true
  validates :g_categoria, presence: true
  validates :slug,  uniqueness: true
  validates :preco, numericality: { greater_than_or_equal_to: 0 }

  before_save :check_remove_imagem

  def should_generate_new_friendly_id?
    slug.blank? || will_save_change_to_nome?
  end

  private

  def set_default_preco
    self.preco ||= 0.0
  end

  def check_remove_imagem
    imagem.purge if remove_imagem == '1'
  end
end

class IProduto < ApplicationRecord
  before_validation :set_default_preco

  has_one_attached :arquivo
  has_one_attached :imagem
  has_many :i_promocoes, through: :i_promocao_produtos
  has_many :i_promocao_produtos 
  belongs_to :g_categoria

  attr_accessor :remove_imagem

  enum status: { inativo: 0, ativo: 1 }

  # Validações básicas
  validates :nome, :slug, :preco, :g_categoria, presence: true
  validates :slug, uniqueness: true
  validates :preco, numericality: { greater_than_or_equal_to: 0 }

  # Scopes úteis
  scope :disponiveis, -> { where(deleted_at: nil) }
  
  before_save :check_remove_imagem

  # SEO-friendly
  def to_param
    slug
  end

  
  private
  
  def set_default_preco
    self.preco ||= 0.0
  end

  def check_remove_imagem
   imagem.purge if remove_imagem == '1'
  end
end

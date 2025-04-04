class IProduto < ApplicationRecord
  belongs_to :g_categoria

  enum status: { inativo: 0, ativo: 1 }

  # Validações básicas
  validates :nome, :slug, :preco, :g_categoria, presence: true
  validates :slug, uniqueness: true
  validates :preco, numericality: { greater_than_or_equal_to: 0 }

  # Scopes úteis
  scope :disponiveis, -> { where(deleted_at: nil) }

  # SEO-friendly
  def to_param
    slug
  end
end

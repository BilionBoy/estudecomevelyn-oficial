# frozen_string_literal: true

class IProduto < ApplicationRecord
  belongs_to :g_categoria

  # Validações básicas
  validates :nome, :slug, :preco, :g_categoria, presence: true
  validates :slug,  uniqueness: true
  validates :preco, numericality: { greater_than_or_equal_to: 0 }

  # Scopes úteis
  scope :ativos, -> { where(status: 'ativo') }
  scope :disponiveis, -> { where(deleted_at: nil) }

  # SEO-friendly
  def to_param
    slug
  end
end

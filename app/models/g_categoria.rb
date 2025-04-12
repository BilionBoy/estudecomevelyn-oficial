# frozen_string_literal: true

class GCategoria < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  has_one_attached :foto_categoria
  belongs_to       :segmento
  validates        :nome, presence: true, uniqueness: true
  validates        :slug, presence: true, uniqueness: true

  before_save :generate_slug

  private 

  def generate_slug
    self.slug = nome.parameterize if slug.blank?
  end
end

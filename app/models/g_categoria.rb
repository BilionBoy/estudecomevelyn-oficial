# frozen_string_literal: true

class GCategoria < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  belongs_to :segmentos

  validates :nome, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  before_save :generate_slug

  private 

  def generate_slug
    self.slug = nome.parameterize if slug.blank?
  end
end

# frozen_string_literal: true

class GCategoria < ApplicationRecord

  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  belongs_to       :segmento
  has_many         :i_produtos
  has_one_attached :foto_categoria

  
  validates        :nome, presence: true, uniqueness: true
  validates        :slug, presence: true, uniqueness: true

  before_save :generate_slug

  private 

  def generate_slug
    self.slug = nome.parameterize if slug.blank?
  end
end

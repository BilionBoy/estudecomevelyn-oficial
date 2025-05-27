class GCategoria < ApplicationRecord
  belongs_to        :segmento
  has_many          :i_produtos, dependent: :destroy
  has_many          :i_cursos,   dependent: :destroy
  has_one_attached  :foto_categoria

  attr_accessor :remove_foto_categoria

  validates :nome, presence: true, uniqueness: true
  validates :slug, presence: true

  before_save :generate_slug
  before_save :remove_foto_categoria_if_needed

  private

  def generate_slug
    if nome.downcase == "cursos"
      self.slug = "cursos"
    else
      self.slug = nome.parameterize if slug.blank?
    end

    count = 1
    original_slug = slug
    while GCategoria.exists?(slug: slug, segmento_id: segmento_id)
      self.slug = "#{original_slug}-#{count}"
      count += 1
    end
  end

  def remove_foto_categoria_if_needed
    foto_categoria.purge if remove_foto_categoria == '1'
  end
end

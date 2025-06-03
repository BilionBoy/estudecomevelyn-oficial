class GCategoria < ApplicationRecord
  extend FriendlyId
  friendly_id :nome, use: :slugged

  belongs_to        :segmento
  has_many          :i_produtos
  has_many          :i_cursos
  has_one_attached  :foto_categoria

  attr_accessor :remove_foto_categoria

  validates :nome, presence: true, uniqueness: true

  before_save :remove_foto_categoria_if_needed

  def should_generate_new_friendly_id?
    slug.blank? || will_save_change_to_nome?
  end

  private

  def remove_foto_categoria_if_needed
    foto_categoria.purge if remove_foto_categoria == '1'
  end
end

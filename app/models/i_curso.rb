class ICurso < ApplicationRecord
  extend FriendlyId
  friendly_id :nome, use: :slugged

  belongs_to :g_categoria
  has_one_attached :imagem_capa

  attr_accessor :remove_imagem_capa

  validates :nome,        presence: true
  validates :descricao,   presence: true
  validates :g_categoria, presence: true
  validates :url_externa, presence: true
  validates :status,      inclusion: { in: ['ativo', 'inativo'] }
  validates :slug,        uniqueness: true

  before_save :check_remove_imagem_capa

  def ativo?
    status == 'ativo'
  end

  def should_generate_new_friendly_id?
    slug.blank? || will_save_change_to_nome?
  end

  private

  def check_remove_imagem_capa
    imagem_capa.purge if remove_imagem_capa == '1'
  end
end

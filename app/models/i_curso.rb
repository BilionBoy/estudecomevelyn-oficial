class ICurso < ApplicationRecord
  belongs_to :g_categoria
  has_one_attached :imagem_capa

  attr_accessor :remove_imagem_capa

  validates :nome,        presence: true
  validates :descricao,   presence: true
  validates :g_categoria, presence: true
  validates :url_externa, presence: true
  validates :slug,        presence: true
  validates :status,      inclusion: { in: ['ativo', 'inativo'] }


  before_save :check_remove_imagem_capa

  def ativo?
    status == 'ativo'
  end

  before_save :generate_slug

  private
  

  def check_remove_imagem_capa
    imagem_capa.purge if remove_imagem_capa == '1'
  end
  
  def generate_slug
    if nome.downcase == "cursos"
      self.slug = "cursos"
    else
      self.slug = nome.parameterize if slug.blank?
    end

    count = 1
    original_slug = slug

    while ICurso.exists?(slug: slug)
      self.slug = "#{original_slug}-#{count}"
      count += 1
    end
  end
end

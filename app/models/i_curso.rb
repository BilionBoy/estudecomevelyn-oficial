class ICurso < ApplicationRecord
  belongs_to :g_categoria
  has_one_attached :imagem_capa

  validates :nome,        presence: true
  validates :descricao,   presence: true
  validates :g_categoria, presence: true
  validates :url_externa, presence: true
  validates :slug,        uniqueness: true
  validates :status,      inclusion: { in: ['ativo', 'inativo'] } # <- aqui a adição nova

  def ativo?
    status == 'ativo'
  end
end

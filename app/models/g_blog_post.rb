# frozen_string_literal: true

class GBlogPost < ApplicationRecord
  belongs_to        :g_blog_categoria
  has_one_attached  :imagem_blog
  
  
  scope :published, -> { where('data_publicacao <= ?', Time.current) }

  before_validation :normalize_email
  
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  validates :titulo,                presence: true
  validates :resumo,                presence:true
  validates :conteudo,              presence: true
  validates :g_blog_categoria_id,   presence: true

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end

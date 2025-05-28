# frozen_string_literal: true

class GBlogPost < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  belongs_to        :g_blog_categoria
  has_one_attached  :imagem_blog

  validates :titulo, :resumo,             presence: true
  validates :titulo, :conteudo,           presence: true
  validates :titulo, :g_blog_categoria,   presence: true

end

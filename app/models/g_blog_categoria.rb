# frozen_string_literal: true

class GBlogCategoria < ApplicationRecord
  has_many :g_blog_posts, dependent: :destroy

  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
end

# frozen_string_literal: true

class Segmento < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  has_many :g_categorias, dependent: :destroy
end

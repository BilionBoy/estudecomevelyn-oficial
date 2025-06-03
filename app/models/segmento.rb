# frozen_string_literal: true

class Segmento < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  has_many :g_categorias, dependent: :destroy

  validates :nome,      presence: true, uniqueness: true
  validates :descricao, presence: true
end

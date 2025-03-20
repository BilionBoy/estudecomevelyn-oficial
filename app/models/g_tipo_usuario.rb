# frozen_string_literal: true

class GTipoUsuario < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  # 
  validates :nome,      presence: true
  validates :descricao, presence: true

  # Callback para converter nome para maiúsculas
  before_save :uppercase_nome

  private

  def uppercase_nome
    self.nome = nome.upcase if nome.present?
  end
end

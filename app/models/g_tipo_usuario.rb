# frozen_string_literal: true

class GTipoUsuario < ApplicationRecord
  # Callback para converter nome para maiúsculas
  before_save :uppercase_nome
  
  validates :nome,      presence: true
  validates :descricao, presence: true
  
  private

  def uppercase_nome
    self.nome = nome.to_s.upcase if nome.present?
  end
end

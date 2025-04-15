# frozen_string_literal: true

class IPromocao < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  has_many :i_promocao_produtos
  has_many :i_produtos, through: :i_promocao_produtos

end

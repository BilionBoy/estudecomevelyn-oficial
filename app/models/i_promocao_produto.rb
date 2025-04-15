# frozen_string_literal: true

class IPromocaoProduto < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  belongs_to :i_promocao
  belongs_to :i_produto
end

class ICarrinho < ApplicationRecord
  belongs_to :usuario, class_name: 'User'
  has_many   :i_itens_carrinhos
end

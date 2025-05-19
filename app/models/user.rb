# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  belongs_to :g_tipo_usuario
  has_many :i_carrinhos, foreign_key: 'usuario_id'
  has_many :i_pedidos, foreign_key: :usuario_id, class_name: 'IPedido'

  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  validates :nome,              presence: true
  validates :email,             presence: true, uniqueness: true
  validates :g_tipo_usuario_id, presence: true 


  def carrinho_ativo
    i_carrinhos.find_or_create_by(status: 'ativo')
  end

  def quantidade_total_itens_no_carrinho
    carrinho = i_carrinhos.find_by(status: 'ativo')
    carrinho&.quantidade_total_itens || 0
  end

end

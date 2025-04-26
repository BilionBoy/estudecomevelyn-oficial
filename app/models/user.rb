# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  belongs_to :g_tipo_usuario
  has_many :i_carrinhos, foreign_key: 'usuario_id'
         
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  validates :nome,              presence: true
  validates :email,             presence: true, uniqueness: true
  validates :g_tipo_usuario_id, presence: true 


  def carrinho_atual
    i_carrinhos.find_by(status: 'ativo')
  end

end

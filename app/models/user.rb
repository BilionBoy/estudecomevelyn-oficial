# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  belongs_to :g_tipo_usuario,   optional: true
  has_many   :i_carrinhos,      foreign_key: :usuario_id
  has_many   :i_pedidos,        foreign_key: :usuario_id

  validates :nome,              presence: true
  validates :email,             presence: true, uniqueness: true
  validates :g_tipo_usuario_id, presence: true
  
  before_validation :set_default_g_tipo_usuario, on: :create

  def carrinho_ativo
    i_carrinhos.find_or_create_by(status: 'ativo')
  end

  def quantidade_total_itens_no_carrinho
    carrinho = i_carrinhos.find_by(status: 'ativo')
    carrinho&.quantidade_total_itens || 0
  end
  
  def admin?
    g_tipo_usuario&.nome == 'ADMIN'
  end

  private

  def set_default_g_tipo_usuario
    return if g_tipo_usuario_id.present?
    
    cliente_tipo = GTipoUsuario.find_by(nome: 'CLIENTE')
    if cliente_tipo
      self.g_tipo_usuario = cliente_tipo
    else
      # Se não encontrar, cria um erro personalizado
      errors.add(:g_tipo_usuario_id, 'Tipo de usuário CLIENTE não encontrado no sistema')
    end
  end
end
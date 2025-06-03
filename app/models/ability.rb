class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    if user.g_tipo_usuario.nome == 'ADMIN'
      can :manage, :all
    else
      # cliente
      can :read, :all
      cannot :manage, [GTipoUsuario, IProduto, ICurso, Segmento, GCategoria, IPromocao, IPromocaoProduto, GBlogCategoria, GBlogPost] 
    end
  end
end

class Store::PixController < ApplicationController
  before_action :authenticate_user!
  before_action :set_carrinho

  def pagar
    # 1. Verifica se o carrinho está válido
    # 2. Cria cobrança Pix com Store::Pix::AsaasClient
    # 3. Busca QR Code
    # 4. Salva cobrança no banco (futuramente)
    # 5. Renderiza view com QR Code
  rescue Store::Pix::AsaasClient::RequestError => e
    # Tratar erro de comunicação com Asaas
    redirect_to store_carrinho_path, alert: "Erro ao gerar Pix: #{e.message}"
  end

  private

  def set_carrinho
    @carrinho = current_user.carrinho_ativo
    redirect_to store_carrinho_path, alert: 'Carrinho não encontrado.' unless @carrinho
  end
end

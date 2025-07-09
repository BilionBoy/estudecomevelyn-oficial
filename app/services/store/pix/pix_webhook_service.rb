class PixWebhookService
  def initialize(raw_payload)
    @raw_payload = raw_payload
  end

  def call
    data = JSON.parse(@raw_payload)
    # Processar o JSON, encontrar/create registro, atualizar status, etc

    # Exemplo simplificado:
    if data['event'] == 'PAYMENT_RECEIVED'
      # lógica para pagamento recebido
      ServiceResult.new(success: true, message: 'Pagamento processado com sucesso')
    else
      ServiceResult.new(success: false, message: "Evento não tratado: #{data['event']}")
    end
  rescue JSON::ParserError => e
    ServiceResult.new(success: false, message: "JSON inválido: #{e.message}")
  end
end

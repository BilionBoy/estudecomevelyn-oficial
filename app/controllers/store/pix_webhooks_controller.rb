module Store
  class PixWebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_webhook_request!

    def receive
      payload = request.body.read
      event = JSON.parse(payload)

      # Aqui você vai delegar para um service processar o webhook
      Store::Pix::WebhookProcessor.new(event).process

      head :ok
    rescue JSON::ParserError
      head :bad_request
    end

    private

    def authenticate_webhook_request!
      # Aqui você pode validar token, assinatura ou IP da requisição
      # Exemplo: comparar um header com token configurado no ENV
      token = request.headers["X-ASAAS-TOKEN"]
      render status: :unauthorized unless ActiveSupport::SecurityUtils.secure_compare(token.to_s, ENV["ASAAS_WEBHOOK_TOKEN"].to_s)
    end
  end
end

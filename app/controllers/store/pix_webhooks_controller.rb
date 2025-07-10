module Store
  class PixWebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :validate_token!

    def receive
      # Chama o service que processa o payload
      result = PixWebhookService.new(request.raw_post).call

      if result.success?
        head :ok
      else
        Rails.logger.error("Erro no webhook Pix: #{result.message}")
        head :bad_request
      end
    end
    private

    def validate_token!
      token = request.headers['X-Webhook-Token'] || params[:token]
      expected_token = Rails.application.credentials.dig(:asaas, :webhook_token) || 'meu_token_webhook_asaas_123'
      unless ActiveSupport::SecurityUtils.secure_compare(token.to_s, expected_token.to_s)
        render status: :unauthorized, json: { error: 'Token inválido' }
      end
    end
  end
end

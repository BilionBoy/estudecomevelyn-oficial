# Configuração global do Stripe
Rails.configuration.stripe = {
  publishable_key: Rails.application.credentials.dig(:stripe, :publishable_key),
  secret_key: Rails.application.credentials.dig(:stripe, :secret_key)
}

Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)

# Log para verificar se a chave foi configurada corretamente
Rails.logger.info "Stripe inicializado. API Key presente: #{Stripe.api_key.present?}"

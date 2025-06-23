require 'httparty'

module Store
  module Pix
    class AsaasClient
      include HTTParty
      base_uri ENV.fetch("ASAAS_SANDBOX", "https://sandbox.asaas.com/api/v3")

      def initialize(api_key:)
        @api_key = api_key
      end

      def create_payment(customer_id:, value:, due_date:, external_reference:)
        payload = build_payment_payload(customer_id:, value:, due_date:, external_reference:)

        response = self.class.post(
          "/payments",
          headers: default_headers,
          body: payload.to_json
        )

        parse_response(response)
      end

      def get_pix_qr_code(payment_id)
        response = self.class.get(
          "/payments/#{payment_id}/pixQrCode",
          headers: default_headers
        )

        parse_response(response)
      end

      private

      def default_headers
        {
          "Content-Type" => "application/json",
          "Accept" => "application/json",
          "Authorization" => "Bearer #{@api_key}"
        }
      end

      def build_payment_payload(customer_id:, value:, due_date:, external_reference:)
        {
          customer: customer_id,
          billingType: "PIX",
          value: value,
          dueDate: due_date.to_s,
          description: "Pagamento do pedido #{external_reference}"
        }
      end

      def parse_response(response)
        return response.parsed_response if response.success?

        raise Asaas::RequestError.new(
          "Erro Asaas: #{response.code}",
          status: response.code,
          body: response.body
        )
      end
    end

    class RequestError < StandardError
      attr_reader :status, :body

      def initialize(message, status:, body:)
        super(message)
        @status = status
        @body = body
      end
    end
  end
end

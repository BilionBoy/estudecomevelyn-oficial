require 'httparty'

module Store
  module Pix
    class AsaasClient
      include HTTParty

      def initialize
        @api_key = Rails.application.credentials.dig(:asaas, :access_token)
        @base_url = Rails.application.credentials.dig(:asaas, :base_url)
        self.class.base_uri @base_url
      end

      def create_customer(name:, cpf_cnpj:)
        payload = {
          name: name,
          cpfCnpj: cpf_cnpj
        }

        response = self.class.post(
          "/customers",
          headers: default_headers,
          body: payload.to_json
        )

        handle_response(response)
      end

      def create_payment(customer_id:, value:, due_date:, external_reference:)
        payload = {
          customer: customer_id,
          billingType: "PIX",
          value: value,
          dueDate: due_date.to_s,
          description: "Pagamento do pedido #{external_reference}"
        }

        response = self.class.post(
          "/payments",
          headers: default_headers,
          body: payload.to_json
        )

        handle_response(response)
      end

      def get_pix_qr_code(payment_id)
        response = self.class.get(
          "/payments/#{payment_id}/pixQrCode",
          headers: default_headers
        )

        handle_response(response)
      end

      private

      def default_headers
        {
          "Content-Type" => "application/json",
          "Accept" => "application/json",
          "access_token" => @api_key,
          "User-Agent" => "MinhaApp/1.0"
        }
      end

      def handle_response(response)
        if response.success?
          response.parsed_response
        else
          raise RequestError.new("Erro Asaas: #{response.code} - #{response.body}", response.code, response.body)
        end
      end
    end

    class RequestError < StandardError
      attr_reader :status, :body
      def initialize(message, status, body)
        super(message)
        @status = status
        @body = body
      end
    end
  end
end

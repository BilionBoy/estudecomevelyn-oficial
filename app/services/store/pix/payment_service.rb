module Store
  module Pix
    class PaymentService
      def initialize(client: AsaasClient.new)
        @client = client
      end

      def create_payment_for(user, value:, due_date:, external_reference:)
        raise "User não tem asaas_customer_id" unless user.asaas_customer_id.present?

        @client.create_payment(
          customer_id: user.asaas_customer_id,
          value: value,
          due_date: due_date,
          external_reference: external_reference
        )
      end

      def get_pix_qr_code(payment_id)
        @client.get_pix_qr_code(payment_id)
      end
    end
  end
end

module Store
  module Pix
    class CustomerService
      def initialize(client: AsaasClient.new)
        @client = client
      end

      def create_customer_for(user)
        return if user.asaas_customer_id.present?

        response = @client.create_customer(
          name: user.nome,
          cpf_cnpj: user.cpf
        )

        user.update!(asaas_customer_id: response["id"])
        response
      end
    end
  end
end

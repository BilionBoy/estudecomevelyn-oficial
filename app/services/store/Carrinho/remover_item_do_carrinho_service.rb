module Store
  module Carrinho
    class RemoverItemDoCarrinhoService
      class ProdutoNaoEncontrado < StandardError; end
      class ItemNaoEncontrado    < StandardError; end

      def initialize(carrinho:, produto_id:)
        @carrinho = carrinho
        @produto_id = produto_id
      end

      def call
        produto = IProduto.find_by(id: produto_id)
        raise ProdutoNaoEncontrado, "Produto não encontrado." unless produto

        item = carrinho.i_itens_carrinhos.find_by(i_produto: produto)
        raise ItemNaoEncontrado, "Item não encontrado no carrinho." unless item

        item.destroy
        { success: true, message: "Item removido com sucesso." }
      end

      private

      attr_reader :carrinho, :produto_id
    end
  end
end

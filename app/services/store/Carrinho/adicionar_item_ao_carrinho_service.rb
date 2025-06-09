module Store
  module Carrinho
    class AdicionarItemAoCarrinhoService
      class ProdutoNaoEncontrado < StandardError; end

      def initialize(carrinho:, produto_id:)
        @carrinho = carrinho
        @produto_id = produto_id
      end

      def call
        produto = IProduto.find_by(id: produto_id)
        raise ProdutoNaoEncontrado, "Produto não encontrado." unless produto

        ja_estava = carrinho.item_presente?(produto)
        carrinho.adicionar_item(produto)

        {
          success: true,
          total_itens: carrinho.quantidade_total_itens,
          item_ja_estava_no_carrinho: ja_estava
        }
      end

      private

      attr_reader :carrinho, :produto_id
    end
  end
end

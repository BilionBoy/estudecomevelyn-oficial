class PedidoMailer < ApplicationMailer
  default from: 'no-reply@estudecomevelyn.com.br' 

  def enviar_infoprodutos(pedido_id)
    @pedido = IPedido.find(pedido_id)
    @usuario = @pedido.usuario

    # Anexa todos os PDFs
    @pedido.i_itens_pedidos.each do |item|
      if item.i_produto.arquivo.attached?
        attachments[item.i_produto.arquivo.filename.to_s] = item.i_produto.arquivo.download
      end
    end

    mail(
      to: @usuario.email,
      subject: "🎉 Obrigado pela compra! Aqui estão seus infoprodutos 📦"
    )
  end
end

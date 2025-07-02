class Store::PixController < ApplicationController
  def create_customer
    service = Store::Pix::CustomerService.new
    customer = service.create_customer_for(current_user)
    render json: customer
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def create_payment
    payment_service = Store::Pix::PaymentService.new
    payment = payment_service.create_payment_for(
      current_user,
      value: 100.0,
      due_date: Date.today + 1,
      external_reference: "pedido_#{current_user.id}_#{Time.now.to_i}"
    )
    render json: payment
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end

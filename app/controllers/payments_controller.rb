class PaymentsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
  end

  def create
    @payment = Payment.create(payment_params)
    # Логіка обробки платежу
    redirect_to order_path(@payment.order)
  end

  private

  def payment_params
    params.require(:payment).permit(:order_id, :amount, :payment_type)
  end
end

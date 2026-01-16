class Api::V1::PaymentsController < ApplicationController
    # def create
    #   @order = Order.find(params[:id])
    # end

    def pay
      byebug
      order = Order.find(params[:order_id])

      begin
        Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
        intent = Stripe::PaymentIntent.create({
          :amount => (order.total_amount/100).to_i,
          :currency => 'usd',
          :payment_method_types => ['card']
        })
        render json: {client_secret: intent.client_secret}
      rescue Stripe::CardError => e
        # Handle card errors
        render json: {error: e.message, code: e.code}, status: :unprocessable_entity
      rescue Stripe::StripeError => e
        # Handle other Stripe errors
        render json: {error: e.message}, status: :unprocessable_entity
      rescue => e
        # Handle other unexpected errors
        render json: {error: "An unexpected error occurred."}, status: :internal_server_error
      end
    end
end




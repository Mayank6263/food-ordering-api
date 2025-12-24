# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      include Pagination

      before_action :find_order, except: %w[index create]
      before_action :order_message, only: %w[update show]
      load_and_authorize_resource param_method: :order_params

      def index
        render json: { orders: OrderSerializer.new(@result), page_detail: page_details }
      end

      def show
        render json: {message: "Your Order is #{ @msg }.",  Order_detail: OrderSerializer.new(@order) }
      end

      def update
        @order.update(status: params[:order][:status])
        render json: { message: "Your Order is #{ @msg }", order_details: @order }
      end

      private

      def order_message
        @msg =  Order::STATUS_MESSAGES[@order.status]
      end

      def order_params
        params.require(:order).permit(:total_amount, :status)
      end

      def find_order
        @order = current_user.orders.find(params[:id])
      end
    end
  end
end

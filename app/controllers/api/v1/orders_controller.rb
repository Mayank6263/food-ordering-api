# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      before_action :find_order, except: %w[index create]

      def index
        orders = Order.all
        render json: { message: 'Your all Orders', data: OrderSerializer.new(orders) }
      end

      def create
        @order = Order.new order_params
        @order.user_id = @current_user.id
        @order.save
        render json: { message: 'Your Order', data: OrderSerializer.new(orders) }
      end

      def show
        render json: OrderSerializer.new(orders)
      end

      def update
        @order.update order_params
        render json: { message: 'Updated Order', data: OrderSerializer.new(@order) }
      end

      def destroy
        @order.destroy
        render json: { message: "Successfully Deleted #{model_name}" }
      end

      private

      def order_params
        params.require(:order).permit(:total_amount, :status)
      end

      def find_order
        @order = Order.find params[:id]
      end
    end
  end
end

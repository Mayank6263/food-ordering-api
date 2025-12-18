# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      before_action :find_order, except: %w[index create]
      load_and_authorize_resource param_method: :order_params

      def index
        orders = @current_user.orders
        render json: { your_orders: 'Your all Orders', data: OrderSerializer.new(orders) }
      end

      def create
        order = Order.new order_params
        order.user_id = current_user.id
        order.save!
        render json: { message: 'Your Order', data: OrderSerializer.new(order) }
      end

      def show
        render json: { Order_detail: OrderSerializer.new(@order) } # include: [:menu_items, :order_items], fields: {except: [:updated_at]}
      end

      def update
        @order.status = params[:order][:status]
        @order.save!
        msg =  Order::STATUS_MESSAGES[@order.status]
        render json: { message: "Your Order is #{ msg }", order_details: @order } # ,
      end

      def destroy
        order.destroy
        render json: { message: 'Successfully Deleted Order.' }
      end

      private

      def order_params
        params.require(:order).permit(:total_amount, :status)
      end

      def find_order
        @order = current_user.orders.find params[:id]
      end
    end
  end
end

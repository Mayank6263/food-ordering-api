# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      before_action :find_order, except: %w[index create]
      before_action :paginate_attributes, only: :index

      load_and_authorize_resource

      def index
        orders = @current_user.orders
        # order_items = orders.map do  |order|
        #   order.order_items
        # end
        render json: { your_orders: 'Your all Orders', data: OrderSerializer.new(orders) }
      end

      def create
        order = Order.new order_params
        order.user_id = current_user.id
        order.save!
        render json: { message: 'Your Order', data: OrderSerializer.new(orders) }
      end

      def show
        render json: { Order_detail: OrderSerializer.new(order) }
      end

      def update
        order.status = params[:order][:status]
        update_total
        render json: { message: msg, order_details: OrderSerializer.new(order) }
      end

      def destroy
        order.destroy
        render json: { message: 'Successfully Deleted Order.' }
      end

      private

      def update_total
        return unless @order.status == 'ordered'

        total = @order.order_items
                      .joins(:menu_item)
                      .sum('quantity * price')
        @order.total_amount = total
        @order.save
      end

      def order_params
        params.require(:order).permit(:total_amount, :status)
      end

      def find_order
        @order = current_user.orders.find params[:id]
      end

      attr_reader :order
    end
  end
end

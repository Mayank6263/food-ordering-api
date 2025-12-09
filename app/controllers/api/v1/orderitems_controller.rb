# frozen_string_literal: true

module Api
  module V1
    class OrderitemsController < ApplicationController
      before_action :find_order_item, except: %w[index create]

      def index
        orderitems = OrderItem.all
        render json: { data: OrderItemSerializer.new(orderitems) }
      end

      def create
        orderitem = OrderItem.create order_item_params
        render json: { message: 'Successfully created OrderItem.', data: OrderItemSerializer.new(orderitem) }
      end

      def show
        render json: OrderItemSerializer.new(@orderitem)
      end

      def update
        @orderitem = OrderItem.update order_item_params
        render json: OrderItemSerializer.new(@orderitem)
      end

      def destroy
        @orderitem.destroy
        render json: { message: 'Successfully deleted Order Item' }
      end

      private

      def order_item_params
        params.require(orderitem).permit(:quantity, :order_id, :menu_item_id)
      end

      def find_order_item
        @orderitem = OrderItem.find params[:id]
      end
    end
  end
end

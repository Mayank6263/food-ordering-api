# frozen_string_literal: true

module Api
  module V1
    class OrderItemsController < ApplicationController
      before_action :find_order_item, except: %w[index create]
      load_and_authorize_resource param_method: :order_item_params

      def index
        render json: { data: OrderItemSerializer.new(@order_items) }
      end

      def create
        order = Order.create(user_id: current_user.id)
        order_item = order.order_items.new order_item_params
        order_item.order_id = params[:order_id]
        order_item.save!
        render json: { message: 'Successfully added Item to cart.', data: order_item }
      end

      def show
        render json: OrderItemSerializer.new(@order_item)
      end

      def update
        order_item = @order_item.update order_item_params
        render json: OrderItemSerializer.new(order_item)
      end

      def destroy
        order_item.destroy
        render json: { message: 'Successfully deleted Order Item' }
      end

      private

      def order_item_params
        params.require(:orderitem).permit(:quantity, :menu_item_id)
      end

      def find_order_item
        @order_item = OrderItem.find params[:id]
      end
    end
  end
end

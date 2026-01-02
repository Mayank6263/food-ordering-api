module Api
  module V1
    class OrderItemsController < ApplicationController
      before_action :find_order_item, only: %w(destroy update)
      before_action :find_order, only: :add_order_item
      load_and_authorize_resource param_method: :order_item_params

      def create
        order = current_user.orders.create!
        order_item = order.order_items.create!(order_item_params.merge(order_id: order.id))
        render json: { message: 'Successfully added Item to cart.', data: OrderItemSerializer.new(order_item) }
      end

      def update
        byebug
        @order_item.update!(order_item_params)
        render json: { message: 'Updated order item.', data: @order_item }
      end

      def add_order_item
        order_item = @order.order_items.create!(order_item_params)
        render json: { message: "Order Added to Cart.", data: OrderSerializer.new(@order) }
      end

      def destroy
        @order_item.destroy
        render json: { message: "Removed Order Item `#{@order_item.menu_item.name}` from Cart." }
      end

      private

      def order_item_params
        params.require(:order_item).permit(:quantity, :menu_item_id)
      end

      def find_order
        @order = current_user.orders.find(params[:order_id])
      end

      def find_order_item
        @order_item = OrderItem.find(params[:id])
      end
    end
  end
end

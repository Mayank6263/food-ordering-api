# frozen_string_literal: true

module Api
  module V1
    class OrderItemsController < ApplicationController
      before_action :find_order_item, except: %w[index create]
      load_and_authorize_resource param_method: :order_item_params

      def index
        orderitems = OrderItem.all
        render json: { data: OrderItemSerializer.new(orderitems) }
      end

      def create
        @order = Order.create(user_id: @current_user.id)
        @orderitem = @order.order_items.new order_item_params
        @orderitem.order_id = params[:order_id]
        @orderitem.save!
        render json: { message: 'Successfully added Item to cart.', data: @orderitem }
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
        params.require(:orderitem).permit(:quantity, :menu_item_id)
      end

      def find_order_item
        @orderitem = OrderItem.find params[:id]
      end
    end
  end
end

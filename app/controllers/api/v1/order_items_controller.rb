# frozen_string_literal: true

module Api
  module V1
    class OrderItemsController < ApplicationController
      before_action :find_order_item, except: %w[index create]
      load_and_authorize_resource param_method: :order_item_params

      def create
        # add_order
        order = Order.create!(user_id: current_user.id)
        order_item = order.add_order(order_item_params)
        order_item = order.order_items.new order_item_params
        order_item.order_id = order.id
        order_item.save!
        render json: { message: 'Successfully added Item to cart.', data: order_item }
      end

      def show
        render json: OrderitemSerializer.new(@order_item)
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

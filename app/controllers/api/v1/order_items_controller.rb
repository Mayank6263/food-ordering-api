module Api
  module V1
    class OrderItemsController < ApplicationController
      before_action :find_order_item, except: :create
      load_and_authorize_resource param_method: :order_item_params

      def create
        order = current_user.orders.create!
        order_item = order.order_items.create!(order_item_params.merge(order_id: order.id))
        render json: { message: 'Successfully added Item to cart.', data: OrderItemSerializer.new(order_item) }
      end



      private

      def order_item_params
        params.require(:order_item).permit(:quantity, :menu_item_id)
      end

      def find_order_item
        @order_item = OrderItem.find params[:id]
      end
    end
  end
end

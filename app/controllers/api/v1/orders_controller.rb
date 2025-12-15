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
        # order_serializer = OrderSerializer.new(@order, except:  :id).to_json
        render json: { Order_detail: OrderSerializer.new(@order) } # include: [:menu_items, :order_items], fields: {except: [:updated_at]}
      end

      def update
        return delivered?
        @order.status = params[:order][:status]
        update_total
        order_status
        @order.save!

        render json: { message: "Your Order is #{@msg}", order_details: @order } # ,
      end

      def destroy
        order.destroy
        render json: { message: 'Successfully Deleted Order.' }
      end

      private

      def delivered?
        render json: { message: "Order cannot be edited Once #{@order.status}ed" } if (@order.status == 'deliver' || @order.status == 'cancel') && (params[:order][:status] == 'deliver' || params[:order][:status] == 'cancel')
      end

      def update_total
        return unless @order.status == 'ordered'

        total = @order.order_items
                      .joins(:menu_item)
                      .sum('quantity * price')
        @order.total_amount = total
        # @order.freeze
      end

      def order_status
        @msg = case @order.status
               when 'ordered'
                 'is on way'
               when 'delivered'
                 'Delivered'
               when 'cancel'
                 'Cancelled'
               else
                 'yet to Order'
               end
      end

      def order_params
        params.require(:order).permit(:total_amount, :status)
      end

      def find_order
        @order = current_user.orders.find params[:id]
      end
    end
  end
end

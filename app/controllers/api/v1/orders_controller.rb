# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      before_action :find_order, except: %w[index create]
      load_and_authorize_resource

      def index
        orders = @current_user.orders
        render json: { message: 'Your all Orders', data: OrderSerializer.new(orders), Order_Items: orders.order_items }
      end

      def create
        @order = Order.new order_params
        @order.user_id = @current_user.id
        @order.save!
        render json: { message: 'Your Order', data: OrderSerializer.new(@orders) }
      end

      def show
        render json: { Order_detail: OrderSerializer.new(@order), Items: @order.order_items }
      end

      def update
        # byebug
        @order.status = params[:order][:status]
        @order.total_amount = @order.menu_items.sum(:price*:quantity) if @order.status == 'ordered'
        @order.save

        case @order.status
        when 'ordered'
          render json: { message: 'Your Order is on way.', order_details: OrderSerializer.new(@order) }
        when 'delivered'
          render json: { message: 'Your Order is delivered Successfully.', order_details: OrderSerializer.new(@order) }
        when 'cancel'
          render json: { message: 'Your Order is Cancelled.', order_details: OrderSerializer.new(@order) }
        else
          render json: { message: 'Your Order is yet to Order.', order_details: OrderSerializer.new(@order) }
        end
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
        # byebug
        @order = @current_user.orders.find params[:id]
      end
    end
  end
end

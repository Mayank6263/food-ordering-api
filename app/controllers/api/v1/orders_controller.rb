# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      before_action :find_order, except: %w[index create]
      load_and_authorize_resource

      def index
        orders = Order.all
        render json: { message: 'Your all Orders', data: OrderSerializer.new(orders) }
      end

      def create
        @order = Order.new order_params
        @order.user_id = @current_user.id
        render json: { message: 'Your Order', data: OrderSerializer.new(@orders) } if @order.save!
      end

      def show
        render json: OrderSerializer.new(@order)
      end

      def update
        @order.update order_params
        case @order.status
        when 'ordered'
          render json: { message: 'Your Order is on way.', order_details: OrderSerializer.new(@order) }
        when 'delivered'
          render json: { message: 'Your Order is delivered Successfully.', order_details: OrderSerializer.new(@order) }
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
        @order = Order.find params[:id]
      end
    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    class RestaurantsController < ApplicationController
      include PaginationConcern
      load_and_authorize_resource param_method: :restro_params
      before_action :find_restro, except: %w[index create]

      def index
        render json: { message: 'All restro ', data: @result, page_detail: @page }
      end

      def create
        restaurant = Restaurant.new restro_params
        restaurant.save!
        render json: { messages: 'Successfully Created Restaurant', data: RestaurantSerializer.new(restaurant) }
      end

      def show
        render json: { message: 'Restaurant Details', data: RestaurantSerializer.new(restaurant) }
      end

      def update
        restaurant = Restaurant.update restro_params
        render json: { data: restaurant }
      end

      def destroy
        restaurant.destroy
        render json: { message: "Successfully deleted Restaurant #{restaurant.name}." }
      end

      private

      def restro_params
        params.require(:restaurant).permit(:name, :address)
      end

      def find_restro
        @restaurant = Restaurant.find params[:id]
      end

      attr_reader :restaurant
    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    class RestaurantsController < ApplicationController
      include Pagination
      load_and_authorize_resource param_method: :restro_params
      before_action :find_restro, except: %w[index create search]

      def index

        render json: { data: @result, page_detail: return_page }
      end

      def create
        restaurant = Restaurant.create! restro_params
        render json: { messages: 'Successfully Created Restaurant', data: RestaurantSerializer.new(restaurant) }
      end

      def show
        render json: { message: 'Restaurant Details', data: RestaurantSerializer.new(@restaurant) }
      end

      def update
        @restaurant.update restro_params
        render json: { message: 'Your Updated Restaurant.',data: @restaurant }
      end

      def search
        query = params[:query]
        restaurant = Restaurant.perform_search(query)
        render json: { message: "Restro ", data: restaurant }
      end

      def destroy
        @restaurant.destroy
        render json: { message: "Successfully deleted Restaurant #{ @restaurant.name }." }
      end

      private

      def restro_params
        params.require(:restaurant).permit(:name,:address)
      end

      def find_restro
        @restaurant = Restaurant.find params[:id]
      end
    end
  end
end

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
        # byebug
        #  unless fetch_lat_long
        #   render json: { message: "Can't find any latitude and longitude. Give a valide addresss" }
        #   return
        # end
        fetch_lat_long
        restaurant.save!
        render json: { messages: 'Successfully Created Restaurant', data: RestaurantSerializer.new(restaurant) }
      end

      def show
        render json: { message: 'Restaurant Details', data: RestaurantSerializer.new(@restaurant) }
      end

      def update
        @restaurant.update restro_params
        byebug
        render json: { message: 'Your Updated Restaurant.',data: @restaurant }
      end

      def destroy
        restaurant.destroy
        render json: { message: "Successfully deleted Restaurant #{restaurant.name}." }
      end

      private

      def fetch_lat_long
        locations = Geocoder.search(params[:restaurant][:address])
        return if locations.empty?
        @result = {}
        @result[:latitude] = locations[0].data["lat"]
        @result[:longitude] = locations[0].data["lon"]
        # extract_lat_longitude
        return @result
      end
      
      # def extract_lat_longitude
      #   restaurant.lat = @result[:latitude]
      #   restaurant.long = @result[:longitude]
      # end

      # def extract_address_from_fetched_location
      # fetch_lat_long 
      # location = @result[0].data["address"]["country"]
      # end

      def restro_params
        params.require(:restaurant).permit(:name,:address)
      end

      def find_restro
        @restaurant = Restaurant.find params[:id]
      end

      # attr_reader :restaurant
    end
  end
end

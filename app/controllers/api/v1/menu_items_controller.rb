module Api
  module V1
    class MenuItemsController < ApplicationController
      include Pagination

      before_action :find_restro, except: :search
      before_action :find_menu_item, only: %w(update destroy)
      load_and_authorize_resource param_method: :menu_items_params

      def index
        render json: { menu_item: MenuItemSerializer.new(@result), page_details: page_details }
      end

      def create
        menu_item = @restro.menu_items.create(menu_items_params)
        render json: MenuItemSerializer.new(menu_item)
      end

      def update
        @menu_item.update menu_items_params
        render json:  MenuItemSerializer.new(@menu_item)
      end

      def search
        menu_items = MenuItem.search_menu(params[:query])
        render json: { data: menu_items }
      end

      def destroy
        @menu_item.destroy
        render json: { message: "Successfully Deleted #{ @menu_item.name }" }
      end

      private

      def menu_items_params
        params.require(:menu_item).permit(:name, :price, :description)
      end

      def find_restro
        @restro = Restaurant.find(params[:restaurant_id])
      end

      def find_menu_item
        @menu_item = @restro.menu_items.find(params[:id])
      end
    end
  end
end

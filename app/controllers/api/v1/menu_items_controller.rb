# frozen_string_literal: true

module Api
  module V1
    class MenuItemsController < ApplicationController
      include Pagination

      before_action :find_restro, except: %w(index create menu_item_search)
      before_action :find_menu_item, only: %w(update show destroy)
      load_and_authorize_resource param_method: :menu_items_params

      def index
        render json: { data: @result, page_details: return_page }
      end

      def create
        menu_item = @restro.menu_items.create menu_items_params
        render json: { message: 'Successfully Created MenuItem.', data: MenuitemSerializer.new(menu_item) }
      end

      def update
        @menu_item.update menu_items_params
        render json: { message: 'MenuItem is Updated Successfully.', data: MenuitemSerializer.new(@menu_item) }
      end

      def show
        render json: { data: MenuItemSerializer.new( @menu_item ) }
      end

      def menu_item_search
        menuitems = MenuItem.search_menu( params[:query] )
        render json: { message: "MenuItems", data: menuitems }
      end

      def restro_item_search
        menuitems = @restro.menu_items.where( "name ilike ?", "%#{params[:query]}%" )
        render json: { message: "MenuItems", data: menuitems }
      end

      def destroy
        @menu_item.destroy
        render json: { message: "Successfully Deleted #{ @menu_item.name }" }
      end

      private

      def menu_items_params
        params.require(:menuitem).permit(:name, :price, :description)
      end

      def find_restro
        @restro = Restaurant.find params[:restaurant_id]
      end

      def find_menu_item
        @menu_item = @restro.menu_items.find params[:id]
      end
    end
  end
end

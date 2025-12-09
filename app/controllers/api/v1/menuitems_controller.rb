# frozen_string_literal: true

module Api
  module V1
    class MenuitemsController < ApplicationController
      before_action :find_menu_item, except: %w[index create]

      def index
        menuitems = MenuItem.all
        render json: { message: 'All available Items.', data: MenuItemSerializer.new(menuitems) }
      end

      def create
        menuitem = MenuItem.create menu_items_params
        render json: { message: 'Successfully Created MenuItem.', data: MenuItemSerializer.new(menuitem) }
      end

      def update
        @menuitem = MenuItem.update menu_items_params
        render json: { message: 'MenuItem is Updated Successfully.', data: MenuItemSerializer.new(menuitem) }
      end

      def show
        render json: { data: MenuItemSerializer.new(menuitem) }
      end

      def destroy
        @menuitem.destroy
        render json: { message: "Successfully Deleted #{@menuitem.name}" }
      end

      private

      def menu_items_params
        params.require(:menuitem).permit(:name, :price, :description, :restaurant_id)
      end

      def find_menu_item
        @menuitem = MenuItem.find params[:id]
      end
    end
  end
end

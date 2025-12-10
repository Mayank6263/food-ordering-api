# frozen_string_literal: true

module Api
  module V1
    class MenuItemsController < ApplicationController
      before_action :find_menu_item, except: %w[index create]
      load_and_authorize_resource param_method: :menu_items_params

      def index
        restro = Restaurant.find params[:restaurant_id]
        menuitems = restro.menu_items.all
        render json: { message: 'All available Items.', data: menuitems }
      end

      def create
        @menuitem = MenuItem.new menu_items_params
        @menuitem.restaurant_id = params[:restaurant_id]
        @menuitem.save!
        render json: { message: 'Successfully Created MenuItem.', data: MenuitemSerializer.new(@menuitem) }
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
        params.require(:menuitem).permit(:name, :price, :description)
      end

      def find_menu_item
        @menuitem = MenuItem.find params[:id]
      end
    end
  end
end

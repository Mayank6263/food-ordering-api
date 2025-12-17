# frozen_string_literal: true

module Api
  module V1
    class MenuItemsController < ApplicationController
      include PaginationConcern
      before_action :find_menu_item, except: %w[index create]
      load_and_authorize_resource param_method: :menu_items_params

      def index
        # byebug
        render json: { message: 'All available Items.', data: @result, page_details: @page }
      end

      def create
        menu_item = MenuItem.new menu_items_params
        menu_item.restaurant_id = params[:restaurant_id]
        menu_item.save!
        render json: { message: 'Successfully Created MenuItem.', data: MenuitemSerializer.new(menu_item) }
      end

      def update
        @menu_item = @menu_item.update menu_items_params
        render json: { message: 'MenuItem is Updated Successfully.', data: MenuItemSerializer.new(menu_item) }
      end

      def show
        render json: { data: MenuItemSerializer.new(@menu_item) }
      end

      def destroy
        @menu_item.destroy
        render json: { message: "Successfully Deleted #{menu_item.name}" }
      end

      private

      def menu_items_params
        params.require(:menuitem).permit(:name, :price, :description)
      end

      def find_menu_item
        @menu_item = MenuItem.find params[:id]
      end
    end
  end
end

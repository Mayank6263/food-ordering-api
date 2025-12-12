# frozen_string_literal: true

class RestaurantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :address, :menu_items, :total_pages, :count, :current_page
end

# frozen_string_literal: true

class MenuItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :price, :description, :restaurant_id

  # has_many :order_items, serializer: OrderSerializer
end

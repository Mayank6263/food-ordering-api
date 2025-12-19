# frozen_string_literal: true

class RestaurantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :address, :menu_items

  # has_many :menu_items
end

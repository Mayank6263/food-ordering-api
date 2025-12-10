# frozen_string_literal: true

class RestaurantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :address
end
